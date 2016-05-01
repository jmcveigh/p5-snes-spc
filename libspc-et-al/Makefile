compile:
	g++ -c -fPIC -D_REENTRANT -D_GNU_SOURCE -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fwrapv -fno-strict-aliasing -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64   -g -fPIC -I/usr/lib64/perl5/CORE dsp.cpp SNES_SPC_misc.cpp spc.cpp SPC_Filter.cpp SNES_SPC.cpp SNES_SPC_state.cpp SPC_DSP.cpp
	ar rcs libspc.a *.o
	sudo cp libspc.a /usr/local/lib
	rm *.o
	rm spc_wrap.c
	swig -perl5 spc.i
	gcc -c -fPIC -D_REENTRANT -D_GNU_SOURCE -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fwrapv -fno-strict-aliasing -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64   -g -fPIC -I/usr/lib64/perl5/CORE spc_wrap.c demo_util.c wave_writer.c demo.c -l:libspc.a
	g++ -fPIC -shared -Wl,-z,relro -L/usr/local/lib -fstack-protector-strong spc_wrap.o demo_util.o wave_writer.o -l:libspc.a -o spc.so
	g++ demo_util.o wave_writer.o demo.o -l:libspc.a -o demo
	sudo cp spc.so /usr/local/share/perl5
	cp spc.pm ~/perl5/lib/perl5
