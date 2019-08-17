module disassembler.instruction;

import disassembler.all;

struct Displacement {
    int value;
    uint numBits;
}
struct Immediate {
    long value;
    uint numBits;
}

struct Instruction {
public:
    /* Copied state */
    ParseStrategy parseStrategy;
    string mnemonic;
    uint fixedSize;
    IS instructionSet;
    /* end of copied state */

    uint offset;
    ubyte[] bytes;  // max length = 15
    Prefix prefix;
    ModRM modrm;
    SIB sib;

    string targetLabel;     // The label of the target instruction if this is a jmp or call
    string label;           // Unique label if this instruction is a jump target

    bool hasModrm;
    bool hasSib;

    Displacement displacement;
    Immediate immediate;

    Operand[] ops;

    this(string mnemonic, inout ParseStrategy parseStrategy, uint fixedSize = 0, IS instructionSet = IS.STD) {
        this.mnemonic       = mnemonic;
        this.parseStrategy  = cast(ParseStrategy)parseStrategy;
        this.fixedSize      = fixedSize;
        this.instructionSet = instructionSet;
    }

    void copy(inout Instruction other) {
        this                = Instruction.init;
        this.mnemonic       = other.mnemonic;
        this.parseStrategy  = cast(ParseStrategy)other.parseStrategy;
        this.fixedSize      = other.fixedSize;
        this.instructionSet = other.instructionSet;
	}

    void addOperand(Operand op) {
        this.ops ~= op;
    }

    bool hasPrefix() const {
        return prefix.bytes.length > 0;
    }
    uint getOperandSize() const {
        if(fixedSize!=0) return fixedSize;
        if(prefix.rexW()) return 64;
        if(prefix.opSize) return 16;
        return 32;
    }
    uint getAddressSize() const {
        if(prefix.addrSize) return 32;
        return 64;
    }

    ubyte[] getBytes(bool canonical = false) {
        if(canonical) {
            auto size = (displacement.numBits + immediate.numBits) / 8;
            if(size>0) {
                return bytes[0..$-size] ~ getZeroBytes(size);
            }
        }
        return bytes;
    }
    string getMnemonicString() {
        string mnemonicStr = mnemonic;

        if(prefix.lock) {
            return "lock " ~ mnemonicStr;
        }
        if(prefix.rep) {
            if(isStringOpcode(mnemonic)) {
                return "rep " ~ mnemonicStr;
            }
        } else if(prefix.repne) {
            if(isStringOpcode(mnemonic)) {
               return "repne " ~ mnemonicStr;
            }
        }
        return mnemonicStr;
    }
    string getOperandsString(Operand.Fmt fmt) {
        if(ops.length==0) {
            return "";
        } else if(ops.length==1) {
            return "%s".format(ops[0].getFormatted(fmt));
        } else if(ops.length==2) {
            return "%s, %s".format(ops[0].getFormatted(fmt),
                                   ops[1].getFormatted(fmt));
        } else if(ops.length==3) {
            return "%s, %s, %s".format(ops[0].getFormatted(fmt),
                                       ops[1].getFormatted(fmt),
                                       ops[2].getFormatted(fmt));
        }
        assert(false, "handle ops.length>3");
    }
    string getMnemonicAndOperandsString(Operand.Fmt fmt) {
        auto ms = getMnemonicString();
        auto os = getOperandsString(fmt);
        return os.length > 0 ? ms ~ " " ~ os : ms;
    }
    string getComments() {
        string comment;
        if(hasPrefix()) {
            comment ~= "; %s".format(prefix.toString());
        }
        if(instructionSet!=IS.STD) {
            if(comment.length==0) comment ~= "; "; else comment ~= " ";
            comment ~= "%s".format(instructionSet);
        }
        return comment;
    }
    string toString() {
        string pb  = formatHexBytes(prefix.bytes, "");
        string ib  = formatHexBytes(bytes[prefix.bytes.length..$], "");
        string pad;
        string pre;
        string suffix = getComments();

        if(pb.length>0) {
            pad = ("%% %ss".format(45 - bytes.length*3)).format("");
            pre = pad ~ "%s : %s".format(pb, ib);
        } else {
            pad = ("%% %ss".format(47 - bytes.length*3)).format("");
            pre = pad ~ "%s".format(ib);
        }

        string offsetStr = " | %04x%s".format(offset, (offset&15)==0 ? "=" : " ");

        string s = pre ~ offsetStr ~ " | " ~ getMnemonicAndOperandsString(Operand.Fmt.CONSOLE);

        pad = ("%% %ss".format(100 - s.length)).format("");

        return s ~ pad ~ suffix;
	}
}