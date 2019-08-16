module disassembler.emit.html.html_output;

import disassembler.all;

final class HTMLOutput {
private:
    string srcFilename;
    string htmlFilename;
    AssemblyOutput assembly;
public:
    this(string srcFilename, string htmlFilename) {
        this.srcFilename  = srcFilename;
        this.htmlFilename = htmlFilename;
        this.assembly     = new AssemblyOutput;
    }
    void add(Instruction[] instructions) {
        assembly.add(instructions);
    }
    void render() {
        auto f = File(htmlFilename, "wb");
        scope(exit) f.close();

        string ml = markup.format(srcFilename, assembly.render());

        f.rawWrite(ml);
    }
private:
    string markup = q"EOS
        <!DOCTYPE html><html>
        <head>
            <title>Disassembled %s</title>
            <meta charset='utf-8'>
            <link rel='stylesheet' href='resources/style.css'/>
            <script type="module" src="resources/controller.mjs"></script>
        </head>
        <body>
            <div id='assembly'>%s</div>
        </body>
        </html>
EOS";
}