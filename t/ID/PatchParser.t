use strict;
use warnings;
use Test::More tests => 6;
use ID::PatchParser;

can_ok("ID::PatchParser","new");

my $fn = "File name";
my $unparsed = "This,is,unparsed,data";
my $patch_parser = new ID::PatchParser(FILENAME => $fn);
isa_ok ($patch_parser, "ID::PatchParser" , "make sure we get object from the contructor");

is ($patch_parser->getFilename(), $fn, "Test getFilename acessor method");

$patch_parser->setUnparsed($unparsed);
is ($patch_parser->getUnparsed(),$unparsed , "Test Unparsed acessor methods");

#There must be a scalar in contructor to pass this test
is (new ID::PatchParser(), undef, "negative test contructor");

#Should return undef right now
is ($patch_parser->Parse(), undef, "Parse has no function right now");

