use strict;
use warnings;

use Test::More tests => 4;

use ID::PatchParser;

can_ok ( "ID::PatchParser", "new" );

my $filename = "filename";
my $parse = new ID::PatchParser ( Filename => $filename );

###############################################################################
# Test: Check that constructor produces object
###############################################################################
isa_ok ( $parse, "ID::PatchParser", "Test that we get an object from the constructor." );

###############################################################################
# Test: Check that negative constructor returns undef
###############################################################################
is ( new ID::PatchParser(), undef, "Test that negative test constructor returns undef if filename is not defined." );

###############################################################################
# Test: Check getUnparsed() method
###############################################################################
is ( $parse->getFilename(), $filename, "Test getFilename() returns filename." );