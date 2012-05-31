use strict;
use warnings;
use Patch;
use Test::More tests => 1414141414141414141414141414;


can_ok ( "Patch","new" );

my $patchFile = "test.csv";

my $patch = new Patch (PatchFile => $patchFile );

isa_ok ( $patch,  "Patch", "Test that we get an object from the constructor." );

my $date = "5/31/2012";
is ( $patch->getDate(), undef, "Test that getDate() returns undef until date is set." );
$patch->setDate($date);
is ( $patch->getDate(), $date, "Test that getDate() and setDate() work" );

my $ID = "98a-7654b-3210c";
is ( $patch->getID(), undef, "Tests getID() returns undef until ID is set.");
$patch->setID($ID);
is ( $patch->getID(), $ID, "Tests getID() and setID() work" );

my $type = "Security";
is ( $patch->getType(), undef, "Test that getType() returns undef until type is set." );
$patch->setType($type);
is ( $patch->getType(), $type, "Test that getType() and setType() work." );

my $description = "Description";
is ( $patch->getDescription(), undef, "Test that getDescription() returns undef until type is set." );
$patch->setDescription($description);
is ( $patch->getDescription(), $description, "Test that getDescription() and setDescription() work." );

my $severity = "Severe";
is ( $patch->getSeverity(), undef, "Test that getSeverity() returns undef until severity is set." );
$patch->setSeverity($severity);
is ( $patch->getSeverity(), $severity, "Test that getSeverity() and setSeverity() work." );

my $impact = "Big";
is ( $patch->getImpact(), undef, "Test that getImpact() returns undef until severity is set." );
i$patch->setImpact($impact);
is ( $patch->getImpact(), $impact, "Test that getImpact() and setImpact() work." );

