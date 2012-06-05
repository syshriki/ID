use strict;
use warnings;
use Data::Dump qw(dump);
use Test::More tests => 5;

use ID::PatchParser;

can_ok("ID::PatchParser","new");

my $unparsed = "THIS IS UNPARSED DATA";

my $patch_parser = new ID::PatchParser(UNPARSED => $unparsed);
isa_ok ($patch_parser, "ID::PatchParser" , "make sure we get object from the contructor");

is ($patch_parser->getUnparsed(), $unparsed, "Test getUnparsed acessor method");

#There must be a scalar in contructor to pass this test
is (new ID::PatchParser(), undef, "negative test contructor");

#Should return undef right now
is ($patch_parser->Parse(), undef, "Parse has no function right now");

is ($patch_parser->getPatch(), undef, "getPatch has no function right now");




