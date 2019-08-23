module disassembler.all;

public:

import std.stdio    			: writefln, File;
import std.format   			: format;
import std.array 				: appender, replace;
import std.algorithm.iteration  : map;
import std.typecons 			: Tuple, tuple;

import common;
import logging;
import resources;

import disassembler;

import disassembler.enums;
import disassembler.instruction;
import disassembler.modrm;
import disassembler.operand;
import disassembler.prefix;
import disassembler.sib;
import disassembler.util;

import disassembler.emit.html.all;

import disassembler.parse.parse_1byte_opcodes;
import disassembler.parse.parse_2byte_opcodes;
import disassembler.parse.parse_3byte_opcodes;
import disassembler.parse.parse_3dnow;
import disassembler.parse.parse_fpu;
import disassembler.parse.parse_groups;
import disassembler.parse.parser;
import disassembler.parse.parse_instruction;
import disassembler.parse.parse_modrm_sib;
import disassembler.parse.parse_prefix;
import disassembler.parse.parse_avx;
import disassembler.parse.parse_avx_page1;
import disassembler.parse.parse_avx_page2;
import disassembler.parse.parse_avx_page3;
import disassembler.parse.parse_avx_groups;

import disassembler.parse.strategy.code;
import disassembler.parse.strategy.operand_info;
import disassembler.parse.strategy.parse_strategy;
import disassembler.parse.strategy.strategy_defs;
import disassembler.parse.strategy.subcode;

enum chatty = true;

void chat(A...)(lazy string fmt, lazy A args) {
	static if(chatty) {
	    log(fmt, args);
		writefln(fmt, args);
	    flushLog();
	}
}