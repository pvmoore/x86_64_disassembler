module disassembler.parse.strategy;

import disassembler.all;

interface ParseStrategy {
    void parse(Parser p);
}

enum Code {
	A,		// A far pointer encoded in the instruction. No ModRM byte in the instruction encoding
	B,		// General purpose reg (VEX/XOP.vvvv)
	C,		// Control reg (modrm.reg)
	D,		// Debug reg (modrm.reg)
	E,		// general purpose reg or mem (modrm.rm)
	F,		// rFLAGS reg
	G,		// general purpose reg (modrm.reg)
	H,		// YMM or XMM reg (VEX/XOP.vvvv)
	I,		// Immediate value
	J,		// The instruction includes a relative offset that is added to the rIP
	L,		// YMM/XMM register specified using the most-significant 4 bits of an 8-bit immediate value
	M,		// A memory operand specified by the ModRM byte. ModRM.mod ≠ 11b
	N,		// 64-bit MMX reg (modrm.rm) - The ModRM.mod field must be 11b
	P,		// 64-bit MMX reg (modrm.reg)
	Q,		// 64-bit MMX reg or mem (modrm.rm)
	R,		// General purpose reg (modrm.rm) - The ModRM mod field must be 11b
	S,		// segment reg (modrm.reg)
	U,		// YMM/XMM reg (modrm.rm) - The ModRM.mod field must be 11b
	V,		// YMM/XMM reg (modrm.reg) - The ModRM mod field must be 11b
	W,	    // YMM/XMM reg or mem (modrm.rm)
}
enum Sub {
	none,
	b,		// 8-bit
	d,		// 32-bit
	do_,    // 256-bit
	d_q,	// d/q - 32-bit or 64-bit
	o,		// 128-bit
	o_q,	// upper/lower half of 128 bits --> 64 bits
	q,		// 64-bit
	p,		// 32-bit or 48-bit far pointer
	pb,		// packed 8-bit
	pdw,	// packed 32-bit (unsigned?)
	pi,		// packed 16-bit
	pj,		// packed 32-bit
	pk,		// packed 8-bit
	pq, 	// packed 64-bit
	pqw,	// packed 64-bit (unsigned?)
	pd,		// packed 64-bit
	ps,		// packed 32-bit
	pw,		// packed 16-bit.
	sd,		// double-scalar
	ss,		// single-scalar
	v,		// 16/32/64-bit depends on operand size
	w,		// 16-bit
	y,		// 32/64-bit depends on operand size
	z,		// 16/32-bit depends on operand size
}

__gshared const {

ParseStrategy ps_none   	= new Composite();
ParseStrategy ps_b      	= new _b;
ParseStrategy ps_v      	= new _v;
ParseStrategy ps_z      	= new _z;
ParseStrategy ps_Fv     	= new Fv;
ParseStrategy ps_Ib     	= new I_sub(Sub.b);
ParseStrategy ps_Iv     	= new I_sub(Sub.v);
ParseStrategy ps_Iw     	= new I_sub(Sub.w);
ParseStrategy ps_Iz     	= new I_sub(Sub.z);
ParseStrategy ps_IwIb   	= new Composite(ps_Iw, ps_Ib);
ParseStrategy ps_ALOv   	= new Composite(new bReg(0), new Ov);
ParseStrategy ps_rAXOv  	= new Composite(new rReg(0), new Ov);
ParseStrategy ps_OvAL   	= new Composite(new Ov, new bReg(0));
ParseStrategy ps_OvrAX  	= new Composite(new Ov, new rReg(0));
ParseStrategy ps_Eb     	= new Eb;
ParseStrategy ps_Eb_1   	= new Composite(new Eb, new b1);
ParseStrategy ps_EbCL   	= new Composite(new Eb, new bReg(1));
ParseStrategy ps_EbIb   	= new Composite(new Eb, ps_Ib);

ParseStrategy ps_Ev_1   	= new Composite(new Ev, new b1);
ParseStrategy ps_Ew     	= new Ew;
ParseStrategy ps_Ev     	= new Ev;
ParseStrategy ps_EvIb   	= new EvIb;
ParseStrategy ps_EvIz   	= new EvIz;
ParseStrategy ps_EvCL   	= new Composite(new Ev, new bReg(1));
ParseStrategy ps_rAXIz  	= new Composite(new rReg(0), ps_Iz);
ParseStrategy ps_ALIb   	= new Composite(new bReg(0), ps_Ib);
ParseStrategy ps_CLIb   	= new Composite(new bReg(1), ps_Ib);
ParseStrategy ps_DLIb   	= new Composite(new bReg(2), ps_Ib);
ParseStrategy ps_BLIb   	= new Composite(new bReg(3), ps_Ib);
ParseStrategy ps_AHIb   	= new Composite(new bReg(4), ps_Ib);
ParseStrategy ps_CHIb   	= new Composite(new bReg(5), ps_Ib);
ParseStrategy ps_DHIb   	= new Composite(new bReg(6), ps_Ib);
ParseStrategy ps_BHIb   	= new Composite(new bReg(7), ps_Ib);
ParseStrategy ps_eAXIb  	= new Composite(new rReg(0), ps_Ib);
ParseStrategy ps_IbAL  		= new Composite(ps_Ib, new bReg(0));
ParseStrategy ps_IbeAX 		= new Composite(ps_Ib, new rReg(0));
ParseStrategy ps_rAXIv  	= new Composite(new rReg(0), ps_Iv);
ParseStrategy ps_rCXIv  	= new Composite(new rReg(1), ps_Iv);
ParseStrategy ps_rDXIv  	= new Composite(new rReg(2), ps_Iv);
ParseStrategy ps_rBXIv  	= new Composite(new rReg(3), ps_Iv);
ParseStrategy ps_rSPIv  	= new Composite(new rReg(4), ps_Iv);
ParseStrategy ps_rBPIv  	= new Composite(new rReg(5), ps_Iv);
ParseStrategy ps_rSIIv  	= new Composite(new rReg(6), ps_Iv);
ParseStrategy ps_rDIIv  	= new Composite(new rReg(7), ps_Iv);
ParseStrategy ps_rCXrAX 	= new Composite(new rReg(1), new rReg(0));
ParseStrategy ps_rDXrAX 	= new Composite(new rReg(2), new rReg(0));
ParseStrategy ps_rBXrAX 	= new Composite(new rReg(3), new rReg(0));
ParseStrategy ps_rSPrAX 	= new Composite(new rReg(4), new rReg(0));
ParseStrategy ps_rBPrAX 	= new Composite(new rReg(5), new rReg(0));
ParseStrategy ps_rSIrAX 	= new Composite(new rReg(6), new rReg(0));
ParseStrategy ps_rDIrAX 	= new Composite(new rReg(7), new rReg(0));
ParseStrategy ps_ALDX   	= new Composite(new bReg(0), new wReg(2));
ParseStrategy ps_DXAL   	= new Composite(new wReg(2), new bReg(0));
ParseStrategy ps_eAXDX  	= new Composite(new eReg(0), new wReg(2));
ParseStrategy ps_DXeAX  	= new Composite(new wReg(2), new eReg(0));
ParseStrategy ps_rAX    	= new rReg(0);
ParseStrategy ps_rCX    	= new rReg(1);
ParseStrategy ps_rDX    	= new rReg(2);
ParseStrategy ps_rBX    	= new rReg(3);
ParseStrategy ps_rSP    	= new rReg(4);
ParseStrategy ps_rBP    	= new rReg(5);
ParseStrategy ps_rSI    	= new rReg(6);
ParseStrategy ps_rDI    	= new rReg(7);
ParseStrategy ps_Jb     	= new Jb;
ParseStrategy ps_Jz     	= new Jz;
ParseStrategy ps_M     		= new M_sub();
ParseStrategy ps_Mb     	= new M_sub(Sub.b);
ParseStrategy ps_Md     	= new M_sub(Sub.d);
ParseStrategy ps_Mp     	= new M_sub(Sub.p);
ParseStrategy ps_Ms     	= new M_sub();
ParseStrategy ps_Mq			= new M_sub(Sub.q);
ParseStrategy ps_Mo			= new M_sub(Sub.o);
ParseStrategy ps_Mw_or_Rv   = new Mw_or_Rv;
ParseStrategy ps_Rv   		= new Rv;
ParseStrategy ps_Uo			= new Uo;
ParseStrategy ps_UoIb	    = new Composite(ps_Uo, ps_Ib);
ParseStrategy ps_Nq			= new Nq;
ParseStrategy ps_Voq        = new Voq;
ParseStrategy ps_NqIb	    = new Composite(ps_Nq, ps_Ib);
ParseStrategy ps_VoqIbIb	= new Composite(ps_Voq, ps_Ib, ps_Ib);





ParseStrategy ps_CdqRdq  	= ModRMSIB.reg_regmem(Code.C, Sub.d_q, Code.R, Sub.d_q);
ParseStrategy ps_DdqRdq  	= ModRMSIB.reg_regmem(Code.D, Sub.d_q, Code.R, Sub.d_q);
ParseStrategy ps_GyEb		= ModRMSIB.reg_regmem(Code.G, Sub.y, Code.E, Sub.b);
ParseStrategy ps_GyEv		= ModRMSIB.reg_regmem(Code.G, Sub.y, Code.E, Sub.v);
ParseStrategy ps_GvMv		= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.M, Sub.v);
ParseStrategy ps_GdNq       = ModRMSIB.reg_regmem(Code.G, Sub.d, Code.D, Sub.q);
ParseStrategy ps_GbEb   	= ModRMSIB.reg_regmem(Code.G, Sub.b, Code.E, Sub.b);
ParseStrategy ps_GdUo		= ModRMSIB.reg_regmem(Code.G, Sub.d, Code.U, Sub.o);
ParseStrategy ps_GdUoIb     = new Composite(ps_GdUo, ps_Ib);
ParseStrategy ps_GdUps  	= ModRMSIB.reg_regmem(Code.G, Sub.d, Code.U, Sub.ps);
ParseStrategy ps_GdUpd  	= ModRMSIB.reg_regmem(Code.G, Sub.d, Code.U, Sub.pd);
ParseStrategy ps_GvEb   	= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.E, Sub.b);
ParseStrategy ps_GvEw   	= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.E, Sub.w);
ParseStrategy ps_GvEd   	= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.E, Sub.d);
ParseStrategy ps_GvEv   	= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.E, Sub.v);
ParseStrategy ps_GvEvIb 	= new Composite(ps_GvEv, ps_Ib);
ParseStrategy ps_GvEvIz 	= new Composite(ps_GvEv, ps_Iz);
ParseStrategy ps_GvM    	= ModRMSIB.reg_regmem(Code.G, Sub.v, Code.M, Sub.none);
ParseStrategy ps_GzMp   	= ModRMSIB.reg_regmem(Code.G, Sub.z, Code.M, Sub.p);
ParseStrategy ps_GdNqIb     = ModRMSIB.reg_regmem(Code.G, Sub.d, Code.N, Sub.q);
ParseStrategy ps_GyWss 		= ModRMSIB.reg_regmem(Code.G, Sub.y, Code.W, Sub.ss);
ParseStrategy ps_GyWsd 		= ModRMSIB.reg_regmem(Code.G, Sub.y, Code.W, Sub.sd);
ParseStrategy ps_PqDq		= ModRMSIB.reg_regmem(Code.P, Sub.q, Code.D, Sub.q);
ParseStrategy ps_PqEw       = ModRMSIB.reg_regmem(Code.P, Sub.q, Code.E, Sub.w);
ParseStrategy ps_PqEwIb     = new Composite(ps_PqEw, ps_Ib);
ParseStrategy ps_PyEy		= ModRMSIB.reg_regmem(Code.P, Sub.y, Code.E, Sub.y);
ParseStrategy ps_PqNq       = ModRMSIB.reg_regmem(Code.P, Sub.q, Code.N, Sub.q);
ParseStrategy ps_PqQd		= ModRMSIB.reg_regmem(Code.P, Sub.q, Code.Q, Sub.d);
ParseStrategy ps_PqQq       = ModRMSIB.reg_regmem(Code.P, Sub.q, Code.Q, Sub.q);
ParseStrategy ps_PqQqIb     = new Composite(ps_PqQq, ps_Ib);
ParseStrategy ps_PpbQpb		= ModRMSIB.reg_regmem(Code.P, Sub.pb, Code.Q, Sub.pb);
ParseStrategy ps_PpbQpbIb   = new Composite(ps_PpbQpb, ps_Ib);
ParseStrategy ps_PpjQpj     = ModRMSIB.reg_regmem(Code.P, Sub.pj, Code.Q, Sub.pj);
ParseStrategy ps_PpiQpi     = ModRMSIB.reg_regmem(Code.P, Sub.pi, Code.Q, Sub.pi);
ParseStrategy ps_PpkQpk     = ModRMSIB.reg_regmem(Code.P, Sub.pk, Code.Q, Sub.pk);
ParseStrategy ps_PqUq  	    = ModRMSIB.reg_regmem(Code.P, Sub.q, Code.U, Sub.q);
ParseStrategy ps_PpjWps     = ModRMSIB.reg_regmem(Code.P, Sub.pj, Code.W, Sub.ps);
ParseStrategy ps_PpjWpd     = ModRMSIB.reg_regmem(Code.P, Sub.pj, Code.W, Sub.pd);
ParseStrategy ps_SwMw   	= ModRMSIB.reg_regmem(Code.S, Sub.w, Code.M, Sub.w);
ParseStrategy ps_VoEw       = ModRMSIB.reg_regmem(Code.V, Sub.o, Code.E, Sub.w);
ParseStrategy ps_VoEwIb   	= new Composite(ps_VoEw, ps_Ib);
ParseStrategy ps_VqMq   	= ModRMSIB.reg_regmem(Code.V, Sub.q, Code.M, Sub.q);
ParseStrategy ps_VoMo   	= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.M, Sub.o);
ParseStrategy ps_VpkMb		= ModRMSIB.reg_regmem(Code.V, Sub.pk, Code.M, Sub.b);
ParseStrategy ps_VpkMbIb	= new Composite(ps_VpkMb, ps_Ib);
ParseStrategy ps_VpsMd	    = ModRMSIB.reg_regmem(Code.V, Sub.ps, Code.M, Sub.d);
ParseStrategy ps_VpsMdIb	= new Composite(ps_VpsMd, ps_Ib);
ParseStrategy ps_VoNq  	    = ModRMSIB.reg_regmem(Code.V, Sub.o, Code.N, Sub.q);
ParseStrategy ps_VoqMq  	= ModRMSIB.reg_regmem(Code.V, Sub.o_q, Code.M, Sub.q);
ParseStrategy ps_VpjWpd		= ModRMSIB.reg_regmem(Code.V, Sub.pj, Code.W, Sub.pd);
ParseStrategy ps_VpdWpj     = ModRMSIB.reg_regmem(Code.V, Sub.pd, Code.W, Sub.pj);
ParseStrategy ps_VoWss  	= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.W, Sub.ss);
ParseStrategy ps_VoWsd  	= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.W, Sub.sd);
ParseStrategy ps_VoWps  	= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.W, Sub.ps);
ParseStrategy ps_VoWq		= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.W, Sub.q);
ParseStrategy ps_VpjEd		= ModRMSIB.reg_regmem(Code.V, Sub.pj, Code.E, Sub.d);
ParseStrategy ps_VpjEdIb	= new Composite(ps_VpjEd, ps_Ib);
ParseStrategy ps_VpqEq		= ModRMSIB.reg_regmem(Code.V, Sub.pq, Code.E, Sub.q);
ParseStrategy ps_VpqEqIb	= new Composite(ps_VpqEq, ps_Ib);
ParseStrategy ps_VyEy		= ModRMSIB.reg_regmem(Code.V, Sub.y, Code.E, Sub.y);
ParseStrategy ps_VpbWpbIb	= new Composite(ps_VpbWpb, ps_Ib);
ParseStrategy ps_VpwWpwIb	= new Composite(ps_VpwWpw, ps_Ib);
ParseStrategy ps_VpwWoq     = ModRMSIB.reg_regmem(Code.V, Sub.pw, Code.W, Sub.o_q);
ParseStrategy ps_VpdwWoq  	= ModRMSIB.reg_regmem(Code.V, Sub.pdw, Code.W, Sub.o_q);
ParseStrategy ps_VpqwWoq  	= ModRMSIB.reg_regmem(Code.V, Sub.pqw, Code.W, Sub.o_q);
ParseStrategy ps_VpdWpd 	= ModRMSIB.reg_regmem(Code.V, Sub.pd, Code.W, Sub.pd);
ParseStrategy ps_VpdWpdIb   = new Composite(ps_VpdWpd, ps_Ib);
ParseStrategy ps_VpbWpb		= ModRMSIB.reg_regmem(Code.V, Sub.pb, Code.W, Sub.pb);
ParseStrategy ps_VpsWps 	= ModRMSIB.reg_regmem(Code.V, Sub.ps, Code.W, Sub.ps);
ParseStrategy ps_VpsWpsIb   = new Composite(ps_VpsWps, ps_Ib);
ParseStrategy ps_VpwWpw     = ModRMSIB.reg_regmem(Code.V, Sub.pw, Code.W, Sub.pw);
ParseStrategy ps_VssWss 	= ModRMSIB.reg_regmem(Code.V, Sub.ss, Code.W, Sub.ss);
ParseStrategy ps_VssWssIb   = new Composite(ps_VssWss, ps_Ib);
ParseStrategy ps_VsdWsd 	= ModRMSIB.reg_regmem(Code.V, Sub.sd, Code.W, Sub.sd);
ParseStrategy ps_VsdWsdIb 	= new Composite(ps_VsdWsd, ps_Ib);
ParseStrategy ps_VpkWpk 	= ModRMSIB.reg_regmem(Code.V, Sub.pk, Code.W, Sub.pk);
ParseStrategy ps_VpkWpkIb   = new Composite(ps_VpkWpk, ps_Ib);
ParseStrategy ps_VpiWpi 	= ModRMSIB.reg_regmem(Code.V, Sub.pi, Code.W, Sub.pi);
ParseStrategy ps_VpjWpj 	= ModRMSIB.reg_regmem(Code.V, Sub.pj, Code.W, Sub.pj);
ParseStrategy ps_VoqWoq     = ModRMSIB.reg_regmem(Code.V, Sub.o_q, Code.W, Sub.o_q);
ParseStrategy ps_VsdEy  	= ModRMSIB.reg_regmem(Code.V, Sub.sd, Code.E, Sub.y);
ParseStrategy ps_VssEy  	= ModRMSIB.reg_regmem(Code.V, Sub.ss, Code.E, Sub.y);
ParseStrategy ps_VqWq   	= ModRMSIB.reg_regmem(Code.V, Sub.q, Code.W, Sub.q);
ParseStrategy ps_VqWqIb 	= new Composite(ps_VqWq, ps_Ib);
ParseStrategy ps_VpbUpb     = ModRMSIB.reg_regmem(Code.V, Sub.pb, Code.U, Sub.pb);
ParseStrategy ps_VoqUo  	= ModRMSIB.reg_regmem(Code.V, Sub.o_q, Code.U, Sub.o);
ParseStrategy ps_VoqUoq 	= ModRMSIB.reg_regmem(Code.V, Sub.o_q, Code.U, Sub.o_q);
ParseStrategy ps_VoqUoqIbIb = new Composite(ps_VoqUoq, ps_Ib, ps_Ib);
ParseStrategy ps_VoWo   	= ModRMSIB.reg_regmem(Code.V, Sub.o, Code.W, Sub.o);
ParseStrategy ps_VoWoIb 	= new Composite(ps_VoWo, ps_Ib);
ParseStrategy ps_VpsQpj 	= ModRMSIB.reg_regmem(Code.V, Sub.ps, Code.Q, Sub.pj);
ParseStrategy ps_VpdQpj 	= ModRMSIB.reg_regmem(Code.V, Sub.pd, Code.Q, Sub.pj);
ParseStrategy ps_VpiWpk     = ModRMSIB.reg_regmem(Code.V, Sub.pi, Code.W, Sub.pk);
ParseStrategy ps_VpiWpj     = ModRMSIB.reg_regmem(Code.V, Sub.pi, Code.W, Sub.pj);
ParseStrategy ps_VpjWpk     = ModRMSIB.reg_regmem(Code.V, Sub.pj, Code.W, Sub.pk);
ParseStrategy ps_VpjWpi     = ModRMSIB.reg_regmem(Code.V, Sub.pj, Code.W, Sub.pi);
ParseStrategy ps_VpqWpk     = ModRMSIB.reg_regmem(Code.V, Sub.pq, Code.W, Sub.pk);
ParseStrategy ps_VpqWpi     = ModRMSIB.reg_regmem(Code.V, Sub.pq, Code.W, Sub.pi);
ParseStrategy ps_VpqWpq     = ModRMSIB.reg_regmem(Code.V, Sub.pq, Code.W, Sub.pq);
ParseStrategy ps_VpqWpqIb	= new Composite(ps_VpqWpq, ps_Ib);
ParseStrategy ps_VpqWpj     = ModRMSIB.reg_regmem(Code.V, Sub.pq, Code.W, Sub.pj);

ParseStrategy ps_EbGb   	= ModRMSIB.regmem_reg(Code.G, Sub.b, Code.E, Sub.b);
ParseStrategy ps_EvGv   	= ModRMSIB.regmem_reg(Code.G, Sub.v, Code.E, Sub.v);
ParseStrategy ps_EvGvIb 	= new Composite(ps_EvGv, ps_Ib);
ParseStrategy ps_EvGvCL 	= new Composite(ps_EvGv, new bReg(1));
ParseStrategy ps_EyPy   	= ModRMSIB.regmem_reg(Code.P, Sub.y, Code.E, Sub.y);
ParseStrategy ps_EyVy   	= ModRMSIB.regmem_reg(Code.V, Sub.y, Code.E, Sub.y);
ParseStrategy ps_EdVpj		= ModRMSIB.regmem_reg(Code.V, Sub.pj, Code.E, Sub.d);
ParseStrategy ps_EdVpjIb	= new Composite(ps_EdVpj, ps_Ib);
ParseStrategy ps_EqVpq		= ModRMSIB.regmem_reg(Code.V, Sub.pq, Code.E, Sub.q);
ParseStrategy ps_EqVpqIb	= new Composite(ps_EqVpq, ps_Ib);
ParseStrategy ps_MvGv		= ModRMSIB.regmem_reg(Code.G, Sub.v, Code.M, Sub.v);
ParseStrategy ps_MqPq		= ModRMSIB.regmem_reg(Code.P, Sub.q, Code.M, Sub.q);
ParseStrategy ps_MwSw   	= ModRMSIB.regmem_reg(Code.S, Sub.w, Code.M, Sub.w);
ParseStrategy ps_MoVo		= ModRMSIB.regmem_reg(Code.V, Sub.o, Code.M, Sub.o);
ParseStrategy ps_MqVoq  	= ModRMSIB.regmem_reg(Code.V, Sub.o_q, Code.M, Sub.q);
ParseStrategy ps_MoVps 		= ModRMSIB.regmem_reg(Code.V, Sub.ps, Code.M, Sub.o);
ParseStrategy ps_MoVpd 		= ModRMSIB.regmem_reg(Code.V, Sub.pd, Code.M, Sub.o);
ParseStrategy ps_MqVq   	= ModRMSIB.regmem_reg(Code.V, Sub.q, Code.M, Sub.q);
ParseStrategy ps_MdVss 		= ModRMSIB.regmem_reg(Code.V, Sub.ss, Code.M, Sub.d);
ParseStrategy ps_MqVsd 		= ModRMSIB.regmem_reg(Code.V, Sub.sd, Code.M, Sub.d);
ParseStrategy ps_MdVps		= ModRMSIB.regmem_reg(Code.V, Sub.ps, Code.M, Sub.d);
ParseStrategy ps_MdVpsIb	= new Composite(ps_MdVps, ps_Ib);
ParseStrategy ps_MwVpw		= ModRMSIB.regmem_reg(Code.V, Sub.pw, Code.M, Sub.w);
ParseStrategy ps_MwVpwIb	= new Composite(ps_MwVpw, ps_Ib);
ParseStrategy ps_MbVpk		= ModRMSIB.regmem_reg(Code.V, Sub.pk, Code.M, Sub.b);
ParseStrategy ps_MbVpkIb    = new Composite(ps_MbVpk, ps_Ib);
ParseStrategy ps_MyGy       = ModRMSIB.regmem_reg(Code.G, Sub.y, Code.M, Sub.y);
ParseStrategy ps_QqPq   	= ModRMSIB.regmem_reg(Code.P, Sub.q, Code.Q, Sub.q);
ParseStrategy ps_RdqCdq  	= ModRMSIB.regmem_reg(Code.C, Sub.d_q, Code.R, Sub.d_q);
ParseStrategy ps_RdqDdq  	= ModRMSIB.regmem_reg(Code.D, Sub.d_q, Code.R, Sub.d_q);
ParseStrategy ps_WpdVpd 	= ModRMSIB.regmem_reg(Code.V, Sub.pd, Code.W, Sub.pd);
ParseStrategy ps_WpsVps 	= ModRMSIB.regmem_reg(Code.V, Sub.ps, Code.W, Sub.ps);
ParseStrategy ps_WqVq  	    = ModRMSIB.regmem_reg(Code.V, Sub.q, Code.W, Sub.q);
ParseStrategy ps_WssVss 	= ModRMSIB.regmem_reg(Code.V, Sub.ss, Code.W, Sub.ss);
ParseStrategy ps_WsdVsd 	= ModRMSIB.regmem_reg(Code.V, Sub.sd, Code.W, Sub.sd);
ParseStrategy ps_WoVo   	= ModRMSIB.regmem_reg(Code.V, Sub.o, Code.W, Sub.o);

} // __gshared const

private:

final class Composite : ParseStrategy {
	private ParseStrategy[] strategies;

	this(const ParseStrategy[] strategies ...) {
		this.strategies = cast(ParseStrategy[])strategies;
	}
	void parse(Parser p) {
		foreach(s; strategies) {
			s.parse(p);
		}
	}
}

final class Eb : ParseStrategy {
	// reg/mem8
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, 8, 0, &op1);
		assert(op1);

		op1.ptrSize = 8;

		p.instr.addOperand(op1);
	}
}
final class Ew : ParseStrategy {

	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, 16, 0, &op1);
		assert(op1);

		op1.ptrSize = 16;

		p.instr.addOperand(op1);
	}
}
final class Ev : ParseStrategy {
	// reg/mem (16/32/64)
	void parse(Parser p) {
		Operand op1;
		parseModrmSib(p, p.instr.getOperandSize(), 0, &op1);
		assert(op1);

		op1.ptrSize = p.instr.getOperandSize();

		p.instr.addOperand(op1);
	}
}
final class EvIb : ParseStrategy {
	// reg/mem (16/32/64), 8 bit imm
	void parse(Parser p) {
		Operand op1;
		parseModrmSib(p, p.instr.getOperandSize(), 0, &op1);
		assert(op1);

		op1.ptrSize = p.instr.getOperandSize();

		p.instr.addOperand(op1);

		// Ib
		auto value = p.readByte();
		p.instr.addOperand(new ImmOperand(value, 8));
		p.instr.immediate = Immediate(value, 8);
	}
}
final class EvIz : ParseStrategy {
	// reg/mem (16/32/64), 16/32 bits
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, p.instr.getOperandSize(), 0, &op1);
		assert(op1);

		op1.ptrSize = minOf(32, p.instr.getOperandSize());

		p.instr.addOperand(op1);

		// Iz
		auto numBits = minOf(32, p.instr.getOperandSize());
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Ov : ParseStrategy {
	// offset coded in the instruction
	void parse(Parser p) {
		todo("implement me");
	}
}

/* 8 bit reg */
final class bReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		auto r = register + 8*p.prefix.rexB();
		p.instr.addOperand(new RegOperand(reg(r , 8, p.prefix.hasRexBits)));
	}
}
/* 16 bit reg */
final class wReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		p.instr.addOperand(new RegOperand(reg(register , 16)));
	}
}
/* 16/32 bit reg */
final class eReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		p.instr.addOperand(new RegOperand(reg(register , minOf(32, p.instr.getOperandSize()))));
	}
}
/* 64 or 32 bit register specified by the register argument */
final class rReg : ParseStrategy {
	int register;

	this(int reg) {
		this.register = reg;
	}
	void parse(Parser p) {
		auto r = p.prefix.rexB() ? register+8 : register;

		p.instr.addOperand(new RegOperand(reg(r , p.instr.getOperandSize())));
	}
}
final class b1 : ParseStrategy {
	// 8 bit value of 1
	void parse(Parser p) {
		p.instr.addOperand(new ImmOperand(1, 8));
	}
}
final class _b : ParseStrategy {
	// 8 bit postfix eg. stosb
	void parse(Parser p) {
		p.instr.mnemonic ~= "b";
	}
}
final class _v : ParseStrategy {
	// 16/32/64 bit postfix eg. stosw/d
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(p.instr.getOperandSize());
	}
}
final class _z : ParseStrategy {
	// 16/32 bit postfix eg. stosw/d
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(minOf(32, p.instr.getOperandSize()));
	}
}
final class Fv : ParseStrategy {
	// rFLAGS 16/32/64 bit postfix eg. pushfd
	void parse(Parser p) {
		p.instr.mnemonic ~= opcodeSizePostfix(p.instr.getOperandSize());
	}
}

final class I_sub : ParseStrategy {
	Sub sub;
	this(Sub sub) { this.sub = sub; }

	void parse(Parser p) {
		uint numBits;

		switch(sub) {
			case Sub.b: numBits = 8; break;
			case Sub.w: numBits = 16; break;
			case Sub.q:
			case Sub.v: numBits = p.instr.getOperandSize(); break;
			case Sub.z: numBits = minOf(p.instr.getOperandSize(), 32); break;

			default: assert(false, "implement me");
		}

		auto value = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}

final class Ib : ParseStrategy {
	// imm8
	void parse(Parser p) {
		auto value = p.readByte();

		p.instr.addOperand(new ImmOperand(value, 8));

		p.instr.immediate = Immediate(value, 8);
	}
}
final class Iw : ParseStrategy {
	// imm16
	void parse(Parser p) {
		auto value = p.readWord();

		p.instr.addOperand(new ImmOperand(value, 16));

		p.instr.immediate = Immediate(value, 16);
	}
}
final class Iv : ParseStrategy {
	// imm (16/32/64)
	void parse(Parser p) {
		auto numBits = p.instr.getOperandSize();
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Iz : ParseStrategy {
	// imm (16/32)
	void parse(Parser p) {
		auto numBits = minOf(p.instr.getOperandSize(), 32);
		auto value   = p.read(numBits);

		p.instr.addOperand(new ImmOperand(value, numBits));

		p.instr.immediate = Immediate(value, numBits);
	}
}
final class Jb : ParseStrategy {
	// 8 bit offset relative to RIP
	void parse(Parser p) {
		int value = p.readByte();

		p.instr.addOperand(new ImmOperand(value, 8));

		p.instr.immediate = Immediate(value, 8);

		// TODO - display label here instead of offset
	}
}
final class Jz : ParseStrategy {
	// 16/32 bit offset relative to RIP

	void parse(Parser p) {
		auto numBits = minOf(p.instr.getOperandSize(), 32);
		auto value   = cast(int)p.read(numBits);

		auto op = new RIPOperand(p.instr.getAddressSize()==64 ? Reg.RIP : Reg.EIP, value);
		p.instr.addOperand(op);

		p.instr.displacement = Displacement(value, numBits);

		/* TODO - fixme
		if(state.instr.opcode=="call" && state.instr.offset+1 in state.objFile.getFixupsForSegment(1))
		{
			//writefln("call @ offset %d",state.instr.offset+1);
			state.instr.str = state.instr.opcode ~ " ";
			EXTDEF[] externs = state.objFile.getExterns();
			FIXUPP[int] fixupsForSegment = state.objFile.getFixupsForSegment(1);
			int targetIndex = fixupsForSegment[state.instr.offset+1].targetIndex;
			//writefln("targetIndex=%d",targetIndex);
			state.instr.str ~= Utils.demangleMethod(externs[targetIndex-1].name);
		}
		else
		{
			// TODO - display a label here instead of an offset
			int off = state.instr.prefix.opSize ? Utils.signExtendWord(a) : a;
			uint labelOffset = state.instr.offset + state.instr.bytes.length + off;
			state.labels.add(labelOffset);
			//state.instr.str = state.instr.opcode ~ " " ~
			//	Utils.formatNumber(state.instr.offset + state.instr.bytes.length + off, 32);
			state.instr.str = state.instr.opcode ~  " " ~ state.labels.get(labelOffset);
		}
		*/

		// if(state.instr.prefix.branch==Branch.TAKE)
		// {
		// 	state.instr.comment ~= "HINT: take branch";
		// }
		// else if(state.instr.prefix.branch==Branch.DONTTAKE)
		// {
		// 	state.instr.comment ~= "HINT: don't take branch";
		// }
	}
}

final class M_sub : ParseStrategy {
	// mem
	Sub sub;

	this(Sub sub = Sub.none) {
		this.sub = sub;
	}

	void parse(Parser p) {

		uint size = p.instr.getOperandSize();
		switch(sub) {
			case Sub.b: size = 8; break;
			case Sub.w: size = 16; break;
			case Sub.d: size = 32; break;
			case Sub.q: size = 64; break;
			case Sub.o: size = 128; break;
			case Sub.p: size = p.prefix.opSize ? 32 : 48; break; // check this
			default: break;
		}

		Operand op1;
		parseModrmSib(p, size, 0, &op1);
		assert(op1);

		op1.ptrSize = size;

		p.instr.addOperand(op1);
	}
}
final class Mw_or_Rv : ParseStrategy {
	void parse(Parser p) {

		uint size = p.prefix.rexW() ? 64 : 16;

		Operand op1;
		parseModrmSib(p, size, 0, &op1);
		assert(op1);

		p.instr.addOperand(op1);
	}
}

final class Rv : ParseStrategy {
	void parse(Parser p) {

		Operand op1;
		parseModrmSib(p, p.instr.getOperandSize(), 0, &op1);
		assert(op1);

		p.instr.addOperand(op1);
	}
}
final class Nq : ParseStrategy {
	// MMX reg (modrm.rm)
	void parse(Parser p) {

		auto rm    = ModRM(p.readByte()).rm;
		Operand op = new RegOperand(RegMMX[rm]);

		p.instr.addOperand(op);
	}
}
final class Uo : ParseStrategy {
	// XMM/YMM reg (modrm.rm)
	void parse(Parser p) {

		auto rm    = ModRM(p.readByte(), p.prefix).rm;
		auto regs  = p.prefix.hasVexBits ? RegYMM : RegXMM;
		Operand op = new RegOperand(regs[rm]);

		p.instr.addOperand(op);
	}
}
final class Voq : ParseStrategy {
	// XMM/YMM reg (modrm.reg)
	void parse(Parser p) {

		auto reg = ModRM(p.readByte()).reg;
		auto regs  = p.prefix.hasVexBits ? RegYMM : RegXMM;
		Operand op = new RegOperand(regs[reg]);

		p.instr.addOperand(op);
	}
}

final class ModRMSIB : ParseStrategy {
	Code dest, src;
	Sub destSub, srcSub;
	bool swap;

	/**
	 *	dest is always the reg
	 *  src is always the reg/mem
	 *  swap = true to swap them
	 */
	private this(Code dest, Sub destSub, Code src, Sub srcSub, bool swap = false) {
		this.dest = dest; this.destSub = destSub;
		this.src  = src; this.srcSub = srcSub;
		this.swap = swap;
	}
	static ModRMSIB reg_regmem(Code dest, Sub destSub, Code src, Sub srcSub) {
		return new ModRMSIB(dest, destSub, src, srcSub, false);
	}
	static ModRMSIB regmem_reg(Code dest, Sub destSub, Code src, Sub srcSub) {
		return new ModRMSIB(dest, destSub, src, srcSub, true);
	}
	void parse(Parser p) {

		Operand regOp;
		Operand regmemOp;
		uint regSize;
		uint regmemSize;

		void _processSubReg(Sub sub, uint* size) {
			switch(sub) {
				case Sub.b:		// 8-bit
					*size = 8;
					break;
				case Sub.d_q:	// 32-bit or 64-bit
					break;
				case Sub.o: 	// 128 bits
					*size = 128;
					break;
				case Sub.o_q:	// upper or lower half of 128 bit --> 64 bit
					*size = 64;
					break;
				case Sub.q:		// 64 bits
					*size = 64;
					break;
				case Sub.ps:
					*size = p.isAVX() ? 256 : 128;
					break;
				case Sub.sd:	// scalar double
				case Sub.ss:	// scalar float
					break;
				case Sub.v:
					*size = p.instr.getOperandSize();
					break;
				case Sub.y:		// 32/64
					*size = maxOf(32, *size);
					break;
				case Sub.z:		// 16/32
					*size = minOf(32, *size);
					break;
				default: assert(false, "implement me");
			}
		}
		void _processSubMem(Sub sub, uint* size) {
			switch(sub) {
				case Sub.b:		// 8-bit
					*size = 8;
					break;
				case Sub.d:		// 32-bit
					*size = 32;
					break;
				case Sub.o: 	// 128 bits
					*size = 128;
					break;
				case Sub.o_q:	// upper or lower half of 128 bit --> 64 bit
					*size = 64;
					break;
				case Sub.p:		// 32-bit or 48-bit
					*size = p.prefix.opSize ? 32 : 48;
					break;
				case Sub.q:		// 64 bits
					*size = 64;
					break;
				case Sub.ps:
					*size = p.isAVX() ? 256 : 128;
					break;
				case Sub.sd:	// scalar double
					*size = 64;
					break;
				case Sub.ss:	// scalar float
					*size = 32;
					break;
				case Sub.v:
					*size = p.instr.getOperandSize();
					break;
				case Sub.w:		// 16-bit
					*size = 16;
					break;
				case Sub.y:		// 32/64
					*size = maxOf(32, *size);
					break;
				case Sub.z:		// 16/32
					*size = minOf(32, *size);
					break;
				case Sub.none:
					break;
				default: assert(false, "implement me");
			}
		}
		void _processCode(Code code, Sub sub, uint* size) {
			switch(code) with(Code) {
				case E:
					*size = p.instr.getOperandSize();
					_processSubMem(sub, size);
					break;
				case G:
					*size = p.instr.getOperandSize();
					_processSubReg(sub, size);
					break;
				case M:
					_processSubMem(sub, size);
					break;
				case N:
				case P:
					*size = 64;
					_processSubReg(sub, size);
					break;
				case Q:
					*size = 64;
					_processSubMem(sub, size);
					break;
				case U:
				case V:
					*size = p.isAVX() ? 256 : 128;
					_processSubReg(sub, size);
					break;
				case W:
					*size = p.isAVX() ? 256 : 128;
					_processSubMem(sub, size);
					break;
				default: assert(false, "implement me");
			}
		}

		_processCode(dest, destSub, &regSize);
		_processCode(src, srcSub, &regmemSize);

		/* Special adjustments */
		switch(p.peekByte(-1)) {
			case 0x7E:
				/* Change movd to movq if opsize is 64-bit */
				if(regmemSize==64) p.instr.mnemonic = "movq";
				break;
			default: break;
		}

		parseModrmSib(p, regmemSize, regSize, &regmemOp, &regOp);

		regmemOp.ptrSize = regmemSize;

		if(swap) {
			p.instr.addOperand(regmemOp);
			p.instr.addOperand(regOp);
		} else {
			p.instr.addOperand(regOp);
			p.instr.addOperand(regmemOp);
		}
	}
}
