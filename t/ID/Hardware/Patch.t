use strict;
use warnings;
use Patch;
use Test::More tests => 6;


can_ok ( "Patch","new" );

my $patchFile = "test.csv";

my $patch = new Patch (PatchFile => $patchFile );

isa_ok ( $patch,  "Patch", "Test that we get an object from the constructor." );

my $date = "5/31/2012";
my $ID = "98a-7654b-3210c";

is ( $patch->getDate(), undef, "Test that getDate() returns undef until date is set." );

$patch->setDate($date);

is ( $patch->getDate(), $date, "Test that getDate() and setDate() work" );

is ( $patch->getID(), undef, "Tests getID() returns undef until ID is set.");

$patch->setID($ID);

is ( $patch->getID(), $ID, "Tests getID() and setID() work" );
