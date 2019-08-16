module disassembler.operand;

import disassembler.all;

abstract class Operand {
public:
    enum Fmt { CONSOLE, CANONICAL, HTML }
    uint ptrSize;   // byte ptr etc
    abstract string getFormatted(Fmt);
protected:
    string ptrSizeString() {
        switch(ptrSize) {
            case 8: return "byte ptr ";
            case 16: return "word ptr ";
            case 32: return "dword ptr ";
            case 48: return "far(48bit) ptr";
            case 64: return "qword ptr ";
            case 128: return "xmmword ptr ";
            case 256: return "ymmword ptr ";
            default: return "";
        }
    }
    string htmlRegString(Reg reg) {
        return "<span class='reg'>%s</span>".format(reg);
    }
}

final class RegOperand : Operand {
    Reg reg;

    this(Reg reg) {
        this.reg = reg;
    }

    override string getFormatted(Fmt fmt) {
        bool console = fmt==Fmt.CONSOLE || fmt==Fmt.CANONICAL;
        return console ? "%s".format(reg) : htmlRegString(reg);
    }
}

//#########################################################################################

final class RegIndexOperand : Operand {
    Reg reg;
    int displacement;
    uint numDispBits;

    this(Reg reg, int displacement, uint numDispBits) {
        this.reg          = reg;
        this.displacement = displacement;
        this.numDispBits  = numDispBits;
    }

    override string getFormatted(Fmt fmt) {
        bool console   = fmt == Fmt.CONSOLE || fmt==Fmt.CANONICAL;
        bool canonical = fmt == Fmt.CANONICAL;

        string s = ptrSizeString();
        if(numDispBits>0) {
            string dispFmt = formatNumber(canonical ? 0 : displacement, numDispBits);
            string plusStr = dispFmt[0]=='-' ? "" : "+";
            return s ~ "[%s%s%sh]".format(formatReg(console), plusStr, dispFmt);
        }
        return s ~ "[%s]".format(formatReg(console));
    }
private:
    string formatReg(bool console) {
        return console ? "%s".format(reg) : htmlRegString(reg);
    }
}

//#########################################################################################

final class SIBOperand : Operand {
    Reg baseReg;
    Reg indexReg;
    Reg segOverride;
    uint scale;
    int displacement;
    uint numDispBits;

    this(Reg baseReg, Reg indexReg, Reg segOverride, uint scale, int displacement, uint numDispBits) {
        this.baseReg      = baseReg;
        this.indexReg     = indexReg;
        this.segOverride  = segOverride;
        this.scale        = 1<<scale;
        this.displacement = displacement;
        this.numDispBits  = numDispBits;
    }

    override string getFormatted(Fmt fmt) {
        bool console   = fmt == Fmt.CONSOLE || fmt==Fmt.CANONICAL;
        bool canonical = fmt == Fmt.CANONICAL;

        auto buf = appender!(string);

        buf ~= ptrSizeString();

        if(segOverride!=Reg.NONE) buf ~= "%s:".format(segOverride);

        buf ~= "[";
        if(baseReg!=Reg.NONE) {
            buf ~= "%s".format(formatBaseReg(console));
        }
        if(indexReg!=Reg.NONE) {
            if(baseReg!=Reg.NONE) buf ~= "+";
            buf ~= "%s".format(formatIndexReg(console));
            if(scale>1) buf ~= "*%s".format(scale);
        }
        if(numDispBits>0) {
            string dispFmt = formatNumber(canonical ? 0 : displacement, numDispBits);

            if(dispFmt[0]!='-' && (baseReg!=Reg.NONE || indexReg!=Reg.NONE)) buf ~= "+";
            buf ~= "%sh".format(dispFmt);
        }
        buf ~= "]";
        return buf.data;
    }
private:
    string formatBaseReg(bool console) {
        return console ? "%s".format(baseReg) : htmlRegString(baseReg);
    }
    string formatIndexReg(bool console) {
        return console ? "%s".format(indexReg) : htmlRegString(indexReg);
    }
}

//#########################################################################################

final class RIPOperand : Operand {
    Reg reg;
    int displacement;

    this(Reg reg, int displacement) {
        this.reg          = reg;
        this.displacement = displacement;
    }

    override string getFormatted(Fmt fmt) {
        bool console   = fmt == Fmt.CONSOLE || fmt==Fmt.CANONICAL;
        bool canonical = fmt == Fmt.CANONICAL;

        string s       = ptrSizeString();
        string num     = formatNumber(canonical ? 0 : displacement, 32);
        string plusStr = num[0]=='-' ? "" : "+";
        return s ~ "[%s%s%sh]".format(formatReg(console), plusStr, num);
    }
private:
    string formatReg(bool console) {
        return console ? "%s".format(reg) : htmlRegString(reg);
    }
}

//#########################################################################################

final class ImmOperand : Operand {
    long value;
    uint numBits;

    this(long value, uint numBits) {
        this.value   = value;
        this.numBits = numBits;
    }

    override string getFormatted(Fmt fmt) {
        bool console   = fmt == Fmt.CONSOLE || fmt==Fmt.CANONICAL;
        bool canonical = fmt == Fmt.CANONICAL;

        return formatNumber(canonical ? 0 : value, numBits) ~ "h";
    }
}