module disassembler.emit.html.assembly_output;

import disassembler.all;

final class AssemblyOutput {
private:
    Instruction[] instructions;
public:
    void add(Instruction[] instructions) {
        this.instructions = instructions;
    }
    string render() {

        auto buf = appender!(string);

        foreach(ref i; instructions) {
            buf ~= "<div class='bytes'>";

            // prefix bytes
            string prefixBytes = formatHexBytes(i.prefix.bytes, "");
            if(i.hasPrefix()) {
                prefixBytes = "[" ~ prefixBytes ~ "] ";
            }
            buf ~= "<span class='pb'>%s</span>".format(prefixBytes);

            // non-prefix bytes
            string nonPrefixBytes = formatHexBytes(i.bytes[i.prefix.bytes.length..$], "");
            buf ~= "<span class='npb'>%s</span>".format(nonPrefixBytes);

            buf ~= "</div>";

            // offset
            string offset = "%04x%s".format(i.offset, (i.offset&15)==0 ? "=" : " ");
            buf ~= "<span class='offset'>%s</span>".format(offset);

            // operands
            buf ~= "<div class='ops'>%s %s</div>".format(i.getMnemonicString(), i.getOperandsString(Operand.Fmt.HTML));

            // comments
            string comments = i.getComments();
            buf ~= "<span class='comment'>%s</span>".format(comments);


        }

        return buf.data;
    }
}