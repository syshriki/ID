use strict;
use warnings;
use ID::Patch;
use ID::PatchParser::Windows;
use Test::More tests => 15;

can_ok ("ID::PatchParser::Windows", "new");

my $fn = "t/testFiles/patchTest.csv";

my $windows = new ID::PatchParser::Windows(FILENAME => $fn);

isa_ok ( $windows, "ID::PatchParser::Windows", "Tests that we get an object from the constructor");

is ( $windows->getFilename(),$fn,"File name accessor test (Inherited)");

my $filecontent ="5/8/2012,\"MS12-035\",2693777,\"Critical\",\"Remote Code Execution\",\"Vulnerabilities in .NET Framework Could Allow Remote Code Execution\",\"Microsoft Windows XP Media Center Edition 2005 Service Pack 3\",2604042,\"Microsoft .NET Framework 1.0 Service Pack 3\",\"Remote Code Execution\",\"Critical\",,\"MS11-078[2572066]\",\"Maybe\",\"CVE-2012-0160,CVE-2012-0161\"\n";

is( ($windows->getFileContent($fn))[0],$filecontent, "Grab text from file");

my @parsed = ("5/8/2012","MS12-035",2693777,"Critical","Remote Code Execution","Vulnerabilities in .NET Framework Could Allow Remote Code Execution","Microsoft Windows XP Media Center Edition 2005 Service Pack 3",2604042,"Microsoft .NET Framework 1.0 Service Pack 3","Remote Code Execution","Critical",,"MS11-078[2572066]","Maybe","CVE-2012-0160,CVE-2012-0161","\n");

is ( $windows->parseCSVLine($filecontent), @parsed, "CSV Parser test");


#example row
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

my $test_patch = $windows->createPatch($date,$ID,$bulletin_kb,$severity,$impact,$title,$affected,$component_kb,$affected,undef,undef,undef,undef,undef,$cve,$type);
is ($test_patch->getDate(),$date,"Tests Parser (Date)");
is ($test_patch->getID(),$ID,"Tests Parser (ID)");
is ($test_patch->getType(),$type,"Tests Parser (Type)");
is ($test_patch->getDescription(),$description,"Tests Parser (Description)");
is ($test_patch->getSeverity(),$severity,"Tests Parser (Severity)");
is ($test_patch->getImpact(),$impact,"Tests Parser (Impact)");
is ($test_patch->getTitle(),$title,"Tests Parser (Title)");
is ($test_patch->getAffected(),$affected,"Tests Parser (Affected)");
is (@{$test_patch->getReferences()},@references,"Tests Parser (References)");

$windows->buildPatchList();
my @patch_list = $windows->getPatchList();

is (@patch_list, 1, "buildPatchList and accessor work");
