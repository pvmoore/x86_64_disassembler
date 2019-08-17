module disassembler.all;

public:

import std.stdio    			: writefln, File;
import std.format   			: format;
import std.array 				: appender, replace;
import std.algorithm.iteration  : map;

import common;
import logging;
import resources;

import disassembler;

import disassembler.enums;
import disassembler.modrm;
import disassembler.prefix;
import disassembler.operand;
import disassembler.sib;

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
import disassembler.parse.parse_vex;
import disassembler.parse.strategy;
import disassembler.util;

import disassembler.instruction;

enum chatty = true;

void chat(A...)(lazy string fmt, lazy A args) {
	static if(chatty) {
	    log(fmt, args);
		writefln(fmt, args);
	    flushLog();
	}
}