%module spc
%{
	#include "spc.h"
%}

%include "cpointer.i"
%include "carrays.i"
%include "malloc.i"
%include "cdata.i"
%include "exception.i"

%array_functions(double,double_arr);
%array_functions(float,float_arr);
%array_functions(int,int_arr);
%array_functions(uint,uint_arr);
%array_functions(short,short_arr);
%array_functions(unsigned char,uchar_arr);
%array_functions(char,char_arr);
%array_functions(bool,bool_arr);

%pointer_functions(double,double_ptr);
%pointer_functions(float,float_ptr);
%pointer_functions(int,int_ptr);
%pointer_functions(uint,uint_ptr);
%pointer_functions(short,short_ptr);
%pointer_functions(unsigned char,uchar_ptr);
%pointer_functions(char,char_ptr);
%pointer_functions(bool,bool_ptr);

%include "spc.h"
