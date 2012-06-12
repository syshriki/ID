use strict;
use warnings;
use ID::Patch;
use Test::More tests => 20;

can_ok ( "ID::Patch","new" );

my $patch = new ID::Patch ();
isa_ok ( $patch,  "ID::Patch", "Test that we get an object from the constructor." );

my $date = "5/31/2012";
is ( $patch->getDate(), undef, "Test that getDate() returns undef until date is set." );
$patch->setDate($date);
is ( $patch->getDate(), $date, "Test that getDate() and setDate() work" );

my $ID = "98a-7654b-3210c";
is ( $patch->getID(), undef, "Test that getID() returns undef until ID is set." );
$patch->setID($ID);
is ( $patch->getID(), $ID, "Tests getID()" );

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
$patch->setImpact($impact);
is ( $patch->getImpact(), $impact, "Test that getImpact() and setImpact() work." );

my $title = "Patch";
is ( $patch->getTitle(), undef, "Test that getTitle() returns undef until title is set." );
$patch->setTitle($title);
is ( $patch->getTitle(), $title, "Test that getTitle() and setTitle() work." );

my $affected = "true";
is ( $patch->getAffected(), undef, "Test that getAffected() returns undef until title is set." );
$patch->setAffected($affected);
is ( $patch->getAffected(), $affected, "Test that getAffected() and setAffected() work." );
 
my @references = qw(source1 source 2);
is ( $patch->getReferences(), undef, "test that getReferences() returns undef until references is set." );
$patch->setReferences(@references);
my @refs = @{$patch->getReferences()};
is (@refs, @references, "Test that getReferences() and setReferences() work." ); 
