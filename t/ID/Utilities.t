use strict;
use warnings;
use Test::More tests => 8;
use ID::Utilities;
can_ok ( "ID::Utilities", "new" );
my $filename = 't/testFiles/utilitiesTest.csv';
my $utils = new ID::Utilities ();

###############################################################################
# Test: Check that constructor produces object
###############################################################################

isa_ok ( $utils, "ID::Utilities", "Test that we get an object from the constructor." );

###############################################################################
# Test: Check parseCSV() method
###############################################################################

my $csv_line = "name,url,support,class";
my @csv_content = $utils->parseCSVFile($filename);
my $csv_line_parsed = $csv_content[-1][0].",".$csv_content[-1][1].",".$csv_content[-1][2].",".$csv_content[-1][3];
is ($csv_line_parsed,$csv_line, "Checks CSV parser");

###############################################################################
# Test: Check parseXLSFile() method
###############################################################################
$filename = "t/testFiles/utilitiesTest.xls";
my $xls_last = "test";
my @xls_content = $utils->parseXLSFile($filename);
is ( $xls_content[-1][-1], $xls_last, "Test that last element of parseXLSFile() is last string in xls file." );
###############################################################################
# Test: Check parsePatchFile() method
###############################################################################
my @parse_content = $utils->parsePatchFile($filename);
is ( $parse_content[-1][-1], $xls_last, "Test that parsesPatchFile() method chooses corret parse sub and returns parsed data." );

is ( $utils->parsePatchFile("Nonsupportedfileformat.txt"), "No parser found to parse TXT files.\n", "Makes sure that parse() can detect unsupported file types." );

###############################################################################
# Test: Check parseHTMLTable() method
###############################################################################

my @headers = qw(Severity Advisory Synopsis Date);
my @htmlparse_content = $utils->parseHTMLTable("http://rhn.redhat.com/errata/rhel-server-6-errata-security.html",\@headers);

is ($htmlparse_content[-1][-1],"2010-11-10","Test that parsePatchFile() method chooses correct parse sub and returns parsed data.");

###############################################################################
# Test: Check getWebFile() method
###############################################################################

$filename = "testUtils(getWebFile)";
$utils->getWebFile($filename,"http://www.google.com/images/srpr/logo3w.png");
is(-e $filename,1,"getWebFile grabs the files and writes them to the disk");
unlink($filename);
