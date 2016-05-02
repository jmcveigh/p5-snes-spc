#include "demo_util.h"

#include <assert.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

unsigned char* load_file( const char* path, long* size_out )
{
	size_t size;
	unsigned char* data;
	
	FILE* in = fopen( path, "rb" );
	if ( !in ) error( "Couldn't open file" );
	
	fseek( in, 0, SEEK_END );
	size = ftell( in );
	if ( size_out )
		*size_out = size;
	rewind( in );
	
	data = (unsigned char*) malloc( size );
	if ( !data ) error( "Out of memory" );
	
	if ( fread( data, 1, size, in ) < size ) error( "Couldn't read file" );
	fclose( in );
	
	return data;
}

void write_file( const char* path, void const* in, long size )
{
	FILE* out = fopen( path, "wb" );
	if ( !out ) error( "Couldn't create file" );
	if ( (long) fwrite( in, 1, size, out ) < size ) error( "Couldn't write file" );
	fclose( out );
}

void error( const char* str )
{
	if ( str )
	{
		fprintf( stderr, "Error: %s\n", str );
		exit( EXIT_FAILURE );
	}
}
