use strict;
use warnings;

use Test::More tests => 10;

use ID::PatchParser::Siemens;

can_ok ( "ID::PatchParser::Siemens", "new" );

my $URL = 'http://support.automation.siemens.com/WW/llisapi.dll/csfetch/18490004/Security_Patches.xls?func=cslib.csFetch&nodeid=47527660';
my $parse = new ID::PatchParser::Siemens ( Unparsed => $URL );

###############################################################################
# Test: Check that constructor produces object
###############################################################################
isa_ok ( $parse, "ID::PatchParser::Siemens", "Test that we get an object from the constructor." );

###############################################################################
# Test: Check that negative constructor returns undef
###############################################################################
is ( new ID::PatchParser::Siemens(), undef, "Test that negative test constructor returns undef in Unparsed is not defined." );

###############################################################################
# Test: Check getUnparsed() method
###############################################################################
is ( $parse->getUnparsed(), $URL, "Test getUnparsed() returns URL." );

###############################################################################
# Test: Check createPatchObject() method
###############################################################################
my @patchObjects = $parse->createPatchObject();
    my $ID = "KB816093";
    my $references = "";
    my $description = "This update helps resolve a vulnerability in the Microsoft virtual machine. After you install this item, you may have to restart your computer. Once you have installed this item, it cannot be removed.";
    my $affected = "816093: Security Update Microsoft Virtual Machine (Microsoft VM)";
    my $date = "2004-06-08";
    my $type = "Security";
is ( $patchObjects[-1]->getID(), $ID, "Test that ID object is created." );
is ( $patchObjects[-1]->getReferences(), $references, "Test that references object is created." );
is ( $patchObjects[-1]->getDescription(), $description, "Test that description object is created." );
is ( $patchObjects[-1]->getAffected(), $affected, "Test that affected object is created." );
is ( $patchObjects[-1]->getDate(), $date, "Test that date object is created." );
is ( $patchObjects[-1]->getType(), $type, "Test that type object is created." );
