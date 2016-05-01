
%module spc
%{
	#include "spc.h"
	#include "demo_util.h"
	#include "wave_writer.h"
%}

%include "cpointer.i"
%include "carrays.i"
%include "cdata.i"

%pointer_functions(long,long_ptr);
%array_functions(short,short_arr);

%include "spc.h"
%include "demo_util.h"
%include "wave_writer.h"
