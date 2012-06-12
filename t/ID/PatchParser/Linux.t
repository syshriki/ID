use strict;
use warnings;

use Test::More tests => 9;

use ID::PatchParser::RHEL;

can_ok ( "ID::PatchParser::RHEL", "new" );

my $URL = 'http://rhn.redhat.com/errata/rhel-server-6-errata-security.html';
my $parse = new ID::PatchParser::RHEL ( Unparsed => $URL );

###############################################################################
# Test: Check that constructor produces object
###############################################################################
isa_ok ( $parse, "ID::PatchParser::RHEL", "Test that we get an object from the constructor." );

###############################################################################
# Test: Check that negative constructor returns undef
###############################################################################
is ( new ID::PatchParser::RHEL(), undef, "Test that negative test constructor returns undef in Unparsed is not defined." );

###############################################################################
# Test: Check getUnparsed() method
###############################################################################
is ( $parse->getUnparsed(), $URL, "Test getUnparsed() returns URL." );

###############################################################################
# Test: Check createPatchObject() method
###############################################################################
my @patchObjects = $parse->createPatchObject();
    my $date = "2010-11-10";
    my $ID = "RHSA-2010:0861";
    my $severity = "Critical";
    my $type = "Security";
    my $description = "$severity: firefox security update";
is ( $patchObjects[-1]->getSeverity(), $severity, "Test that severity object is created." );
is ( $patchObjects[-1]->getID(), $ID, "Test that ID object is created." );
is ( $patchObjects[-1]->getDescription(), $description, "Test that description object is created." );
is ( $patchObjects[-1]->getDate(), $date, "Test that date object is created." );
is ( $patchObjects[-1]->getType(), $type, "Test that type object is created." );
