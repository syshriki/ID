use warnings;
use Test::More tests => 5;

use ID::PatchParser::ABB;

can_ok("ID::PatchParser::ABB","new");

my $unparsed = "datafile.ini";

my $abb_patch_parser = new ID::PatchParser::ABB( Filename  => $unparsed );
isa_ok ($abb_patch_parser, "ID::PatchParser::ABB" , "Make sure we get object from the contructor");

#There must be a scalar in contructor to pass this test
is (new ID::PatchParser::ABB(), undef, "negative test contructor");

is ($abb_patch_parser->getFilename(), $unparsed, "Test getUnparsed acessor method");

my $abb_parse_return = "ABBPARSE"; #This is what the overridden function Parse() should return for now
is ($abb_patch_parser->Parse(), $abb_parse_return, "negative test contructor");



