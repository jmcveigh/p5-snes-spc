#include "dsp.h"

#include "SPC_DSP.h"

#include "blargg_source.h"

SPC_DSP* spc_dsp_new( void )
{
	// be sure constants match
	assert( spc_dsp_voice_count     == (int) SPC_DSP::voice_count );
	assert( spc_dsp_register_count  == (int) SPC_DSP::register_count );
	#if !SPC_NO_COPY_STATE_FUNCS
	assert( spc_dsp_state_size      == (int) SPC_DSP::state_size );
	#endif
	
	return new SPC_DSP;
}

void spc_dsp_delete      ( SPC_DSP* s )                                 { delete s; }
void spc_dsp_init        ( SPC_DSP* s, void* ram_64k )                  { s->init( ram_64k ); }
void spc_dsp_set_output  ( SPC_DSP* s, spc_dsp_sample_t* p, int n )     { s->set_output( p, n ); }
int  spc_dsp_sample_count( SPC_DSP const* s )                           { return s->sample_count(); }
void spc_dsp_reset       ( SPC_DSP* s )                                 { s->reset(); }
void spc_dsp_soft_reset  ( SPC_DSP* s )                                 { s->soft_reset(); }
int  spc_dsp_read        ( SPC_DSP const* s, int addr )                 { return s->read( addr ); }
void spc_dsp_write       ( SPC_DSP* s, int addr, int data )             { s->write( addr, data ); }
void spc_dsp_run         ( SPC_DSP* s, int clock_count )                { s->run( clock_count ); }
void spc_dsp_mute_voices ( SPC_DSP* s, int mask )                       { s->mute_voices( mask ); }
void spc_dsp_disable_surround( SPC_DSP* s, int disable )                { s->disable_surround( disable ); }
void spc_dsp_load        ( SPC_DSP* s, unsigned char const regs [spc_dsp_register_count] ) { s->load( regs ); }

#if !SPC_NO_COPY_STATE_FUNCS
void spc_dsp_copy_state  ( SPC_DSP* s, unsigned char** p, spc_dsp_copy_func_t f ) { s->copy_state( p, f ); }
int  spc_dsp_check_kon   ( SPC_DSP* s )                                 { return s->check_kon(); }
#endif
