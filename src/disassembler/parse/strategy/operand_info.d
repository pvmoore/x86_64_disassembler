module disassembler.parse.strategy.operand_info;

import disassembler.all;

Reg getReg(uint index, uint regSize, bool rex = false) {
	Reg r;

	switch(regSize) {
		case 256: r = RegYMM[index]; break;
		case 128: r = RegXMM[index]; break;
		case 64: r = Reg64[index]; break;
		case 32: r = Reg32[index]; break;
		case 16: r = Reg16[index]; break;
		case 8:
			if(rex) r = Reg8_rex[index];
			else r = Reg8[index];
			break;
		default: assert(false);
	}

	//chat("reg(index=%s regSize=%s) ==> %s", index, regSize, r);
	return r;
}

Reg getReg(Parser p, uint index, CodeAndSub code = CodeAndSub(Code.none, Sub.none)) {
	Reg r;

	if(code.code!=Code.none) {
		r = getRegs(p, code.code, code.sub)[index];
	} else {
		/* must be a 64-bit index reg */
		r = Reg64[index];
	}

	//chat("reg(index=%s code=%s) ==> %s", index, code, r);
	return r;
}

uint getPtrSize(Parser p, CodeAndSub dest, CodeAndSub src) {
	uint size;

	//chat("dest = %s src = %s", dest, src);

	if(src.sub == dest.sub) {
		return src.sub.getRegSize(p);
	}

	// if(dest.code.isReg()) {
	// 	size = dest.sub.getRegSize(p);
	// } else {
		size = src.sub.getMemSize(p);
	//}

	if(size==0) {
		/* Get the size from the reg side */
		if(src.code.isReg()) {
			size = src.sub.getRegSize(p);
		}
		if(dest.code.isReg()) {
			size = dest.sub.getRegSize(p);
		}
	}

	return size;
}

immutable(Reg*) getRegs(Parser p, Code code, Sub sub) {

	auto _getRegs(uint size) {
		switch(size) {
			case 256: return RegYMM.ptr;
			case 128: return RegXMM.ptr;
			case 64: return Reg64.ptr;
			case 32: return Reg32.ptr;
			case 16: return Reg16.ptr;
			case 8:
				if(p.hasRex()) return Reg8_rex.ptr;
				return Reg8.ptr;
			default: assert(false);
		}
	}

	switch(code) with(Code) {
		/* reg only */
		case G: return _getRegs(sub.getRegSize(p));
		case B: return _getRegs(code.getSize(p));
		case C: return RegC.ptr;
		case D: return RegD.ptr;
		case R:
			return _getRegs(code.getSize(p));
		case H:
			return _getRegs(code.getSize(p));
		case N:
		case P:
			return RegMMX.ptr;
		case S:
			return RegSeg.ptr;
		case U:
		case V:
		case L:
			return _getRegs(code.getSize(p));

		/* mem only */
		case M:
		case MSTAR:
			// shouldn't get here
			break;

		/* reg or mem */
		case E:
			return _getRegs(sub.getRegSize(p));
		case Q:
			return RegMMX.ptr;
		case W:
			if(sub==Sub.sd) return _getRegs(128);
			return _getRegs(code.getSize(p));

		default: break;
	}
	assert(false, "implement me %s %s".format(code, sub));
}

