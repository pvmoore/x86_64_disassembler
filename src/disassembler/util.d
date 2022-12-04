module disassembler.util;

import disassembler.all;

__gshared immutable HEX = "0123456789abcdef";

string formatHexBytes(inout ubyte[] bytes, string prefix = "0x", string sep = " ") {
    if(bytes.length==0) return "";

    auto buf = appender!(string);
    for(auto i=0; i<bytes.length; i++) {
        if(i>0) buf ~= sep;

        buf ~= "%s%02x".format(prefix, bytes[i]);
    }
    return buf.data;
}
string formatNumber(long num, int numBits) {

    auto q = new Queue!char(32);
    int numNibbles = numBits >> 2;

    bool neg;

    if(numBits==8 && (num&(1<<7))!=0)   { num = -num; neg = true; }
    if(numBits==16 && (num&(1<<15))!=0) { num = -num; neg = true; }
    if(numBits==32 && (num&(1<<31))!=0) { num = -num; neg = true; }
    if(numBits==64 && (num&(1L<<63))!=0) { num = -num; neg = true; }

    for(int i=numNibbles-1; i>=0; i--) {
        int nibble = num & 0xf;
        q.pushToFront(HEX[nibble]);
        num>>>=4;
    }

    if(neg) q.pushToFront('-');

    return cast(string)q.valuesDup();
}
T maxOf(T)(T a, T b) {
    return a > b ? a : b;
}
T minOf(T)(T a, T b) {
    return a < b ? a : b;
}
ubyte[] getZeroBytes(uint num) {
    ubyte[] bytes;
    bytes.length = num;
    bytes[] = 0;
    return bytes;
}
char opcodeSizePostfix(uint numBits) {
    switch(numBits) {
        case 8: return 'b';
        case 16: return 'w';
        case 32: return 'd';
        case 64: return 'q';
        default: assert(false);
    }
}
bool isStringOpcode(string mnemonic) {
    switch(mnemonic) {
        case "stos": case "stosb": case "stosw": case "stosd": case "stosq":
            return true;
        // todo - do the rest
        default:
            return false;
    }
}