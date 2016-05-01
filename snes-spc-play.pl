#!/bin/perl
use warnings;
use strict;

use spc;

use Audio::PortAudio;

use feature 'say';

use constant PLAYBACK_BUFFER_SIZE => 2048;

my $snes_spc = spc::spc_new;
my $spc_filter = spc::spc_filter_new;

die "ERROR: an error occurred allocating memory for the emulator\n" if (!$snes_spc || !$spc_filter);

my $spc_size_ptr = spc::new_long_ptr;

my $in_file = $ARGV[-1];

die "USAGE: snes-spc-play.pl input-file.spc\n" unless (-r $in_file);

my $file_contents = spc::load_file($in_file, $spc_size_ptr);

my $spc_size = spc::long_ptr_value($spc_size_ptr);

spc::spc_load_spc($snes_spc, $file_contents, $spc_size);
spc::spc_clear_echo($snes_spc);
spc::spc_filter_clear($spc_filter);

my $api = Audio::PortAudio::default_host_api;
my $device = $api->default_output_device;

my $stream = $device->open_write_stream(
	{
		channel_count => 1,
		sample_format => 'int32',
	},
	$spc::spc_sample_rate,
	8000,
);


use constant LAST_SEG_MARKER => 28;

my $last_seg_count = 0;

while(1)
{
	my $buffer = spc::new_short_arr(PLAYBACK_BUFFER_SIZE);

	spc::spc_play($snes_spc, PLAYBACK_BUFFER_SIZE, $buffer);
	spc::spc_filter_run($spc_filter, $buffer, PLAYBACK_BUFFER_SIZE);
	
	my @blips = map { 
		spc::short_arr_getitem($buffer, $_);
	} 0 .. (PLAYBACK_BUFFER_SIZE - 1);
	
	my $playback_buffer = pack('s*',@blips);
	
	$stream->write($playback_buffer);

	spc::delete_short_arr($buffer);
	
	$last_seg_count++ if ($blips[-1] == 0 && $blips[-2] == 0 && $blips[0] == 0 && $blips[1] == 0);
	last if($last_seg_count == LAST_SEG_MARKER);
}

spc::spc_filter_delete($spc_filter);
spc::spc_delete($snes_spc);

1;
