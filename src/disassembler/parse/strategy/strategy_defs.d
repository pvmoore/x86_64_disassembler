module disassembler.parse.strategy.strategy_defs;

import disassembler.all;

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
ParseStrategy ps_MqVsd 		= ModRMSIB.regmem_reg(Code.V, Sub.sd, Code.M, Sub.q);
ParseStrategy ps_MdVps		= ModRMSIB.regmem_reg(Code.V, Sub.ps, Code.M, Sub.d);
ParseStrategy ps_MdVpsIb	= new Composite(ps_MdVps, ps_Ib);
ParseStrategy ps_MqVps		= ModRMSIB.regmem_reg(Code.V, Sub.ps, Code.M, Sub.q);
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


/* AVX */
const ParseStrategy ps_GyUpsx       = ModRMSIB.avx("Gy", "Upsx");
const ParseStrategy ps_GyUpdx       = ModRMSIB.avx("Gy", "Updx");

const ParseStrategy ps_MqVo			= ModRMSIB.avx("Mq", "Vo");
const ParseStrategy ps_MqVpd		= ModRMSIB.avx("Mq", "Vpd");
const ParseStrategy ps_MpsxVpsx 	= ModRMSIB.avx("Mpsx", "Vpsx");
const ParseStrategy ps_MpdxVpdx 	= ModRMSIB.avx("Mpdx", "Vpdx");

const ParseStrategy ps_VpsxWpsx   	= ModRMSIB.avx("Vpsx", "Wpsx");
const ParseStrategy ps_VpsHpsMq     = ModRMSIB.avx("Vps", "Hps", "Mq");
const ParseStrategy ps_VpsxHpsxWpsx = ModRMSIB.avx("Vpsx", "Hpsx", "Wpsx");
const ParseStrategy ps_VpdxWpdx		= ModRMSIB.avx("Vpdx", "Wpdx");
const ParseStrategy ps_VpdxHpdxWpdx = ModRMSIB.avx("Vpdx", "Hpdx", "Wpdx");
const ParseStrategy ps_VpdHpdMq		= ModRMSIB.avx("Vpd", "Hpd", "Mq");
const ParseStrategy ps_VoHoMq		= ModRMSIB.avx("Vo", "Ho", "Mq");
const ParseStrategy ps_VpsHpsUps	= ModRMSIB.avx("Vps", "Hps", "Ups");
const ParseStrategy ps_VssHssUss	= ModRMSIB.avx("Vss", "Hss", "Uss");
const ParseStrategy ps_VssMd		= ModRMSIB.avx("Vss", "Md");
const ParseStrategy ps_VsdMq		= ModRMSIB.avx("Vsd", "Mq");
const ParseStrategy ps_VsdHsdUsd	= ModRMSIB.avx("Vsd", "Hsd", "Usd");
const ParseStrategy ps_VdoWdo 		= ModRMSIB.avx("Vdo", "Wdo");
const ParseStrategy ps_VoHoEy 		= ModRMSIB.avx("Vo", "Ho", "Ey");
const ParseStrategy ps_VoHoWss      = ModRMSIB.avx("Vo", "Ho", "Wss");
const ParseStrategy ps_VoHoWsd      = ModRMSIB.avx("Vo", "Ho", "Wsd");
const ParseStrategy ps_VssHssWss    = ModRMSIB.avx("Vss", "Hss", "Wss");
const ParseStrategy ps_VpsxWpdx     = ModRMSIB.avx("Vpsx", "Wpdx");
const ParseStrategy ps_VpjxWpsx     = ModRMSIB.avx("Vpjx", "Wpsx");
const ParseStrategy ps_VpdxWpsx     = ModRMSIB.avx("Vpdx", "Wpsx");
const ParseStrategy ps_VpsxWpjx     = ModRMSIB.avx("Vpsx", "Wpjx");
const ParseStrategy ps_VsdHsdWsd    = ModRMSIB.avx("Vsd", "Hsd", "Wsd");

const ParseStrategy ps_UssHssVss	= ModRMSIB.avx("Uss", "Hss", "Vss");
const ParseStrategy ps_UsdHsdVsd	= ModRMSIB.avx("Usd", "Hsd", "Vsd");

const ParseStrategy ps_WpsxVpsx     = ModRMSIB.avx("Wpsd", "Vpsx");
const ParseStrategy ps_WpdxVpdx		= ModRMSIB.avx("Wpdx", "Vpdx");
const ParseStrategy ps_WpsxVpws 	= ModRMSIB.avx("Wpsx", "Vpsx");








//const ParseStrategy xxxx = ModRMSIB.avx("Usd", "Hsd", "Vsd");

} // __gshared const
