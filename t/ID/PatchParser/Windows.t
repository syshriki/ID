use strict;
use warnings;
use ID::Patch;
use ID::PatchParser::Windows;
use Test::More tests => 16;

can_ok ("ID::PatchParser::Windows", "new");

my $fn = "t/testFiles/patchTest.csv";

my $windows = new ID::PatchParser::Windows(FILENAME => $fn);

isa_ok ( $windows, "ID::PatchParser::Windows", "Tests that we get an object from the constructor");

is ( $windows->getFilename(),$fn,"File name accessor test (Inherited)");

#Data in last part of patchTest
my $date = "5/8/2012";
my $ID = "MS12-035";
my $severity = "Critical";
my $title = "Vulnerabilities in .NET Framework Could Allow Remote Code Execution";
my $type = "security";
my $affected ="Microsoft Windows XP Media Center Edition 2005 Service Pack 3";
my $impact = "Remote Code Execution";
my $bulletin_kb = "2693777";
my $component_kb = "2604042";
my $cve = "CVE-2012-0160,CVE-2012-0161";
my $description = "$severity "." $title for $affected";
my @references = qw($id $bulletin_kb $component_kb $cve);

#Patch list created with data fro patchTest
my @patches = $windows->createPatchObjects($fn);

#Last element in @pathces
my $test_patch = $patches[-1];

#The following test check the content of the patch to make sure its correct
is ($test_patch->getDate(),$date,"Tests Parser (Date)");
is ($test_patch->getID(),$ID,"Tests Parser (ID)");
is ($test_patch->getType(),$type,"Tests Parser (Type)");
is ($test_patch->getDescription(),$description,"Tests Parser (Description)");
is ($test_patch->getSeverity(),$severity,"Tests Parser (Severity)");
is ($test_patch->getImpact(),$impact,"Tests Parser (Impact)");
is ($test_patch->getTitle(),$title,"Tests Parser (Title)");
is ($test_patch->getAffected(),$affected,"Tests Parser (Affected)");
my @refs = @{$test_patch->getReferences()};
is (@refs,@references,"Tests Parser (References) count");
is ($refs[0],$ID,"Tests Parser (References) ID");
is ($refs[1],$bulletin_kb, "Tests Parser (References) bulletin kb");
is ($refs[2],$component_kb, "Tests Parser (References) component kb");
is ($refs[3],$cve, "Tests Parser (References) cve");
