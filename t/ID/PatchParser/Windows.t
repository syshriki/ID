use strict;
use warnings;
use ID::PatchParser::Windows;
use ID::Patch;
use Test::More tests => 2;

can_ok ("ID::PatchParser::Windows", "new");

my $windows = new ID::PatchParser::Windows();

isa_ok ( $windows, "ID::PatchParser::Windows", "Tests that we get an object from the constructor");

#example row
my $date = "Date";
my $ID = "ID";
my $severity = "Severity";
my $title = "title";
my $type = "security";
my $affected = "affected";
my $bulletin_kb = "Bulletin KB";
my $component_kb = "Component KB";
my $cve = "cve";
my $description = "$severity "." $title for $affected;
my @references = qw(id bulletin_kb component_kb cve);
my @example_row = {$date,$ID,$type,$description,$severity,$impact,$title,$affected,@references};

is ($windows->ParseRow(@example_row)->getDate(),$date,"Tests Parser (Date)");
is ($windows->ParseRow(@example_row)->getID(),$ID,"Tests Parser (ID)");
is ($windows->ParseRow(@example_row)->getType(),$type,"Tests Parser (Type)");
is ($windows->ParseRow(@example_row)->getDescription(),$description,"Tests Parser (Description)");
is ($windows->ParseRow(@example_row)->getSeverity(),$severity,"Tests Parser (Severity)");
is ($windows->ParseRow(@example_row)->getImpact(),$impact,"Tests Parser (Impact)");
is ($windows->ParseRow(@example_row)->getTitle(),$title,"Tests Parser (Title)");
is ($windows->ParseRow(@example_row)->getAffected(),$affected,"Tests Parser (Affected)");
is ($windows->ParseRow(@example_row)->getReferences(),$references,"Tests Parser (References)");









