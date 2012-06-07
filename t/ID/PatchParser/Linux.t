use strict;
use warnings;
use ID::Patch;
use ID::PatchParser::Linux;
use Test::More tests => 12;


can_ok ( "ID::PatchParser::Linux","new" );

my $fn = 'lib/ID/PatchParser/Scripts/cfgs/urls.ini';
my $linux = new ID::PatchParser::Linux(FILENAME => 'lib/ID/PatchParser/Scripts/cfgs/urls.ini');

isa_ok ( $linux, "ID::PatchParser::Linux", "Tests that we get an object from the constructor");

is ( $linux->getFilename(),$fn,"File name accessor test (Inherited)");

#This is all data to test that the parser has the correct output
#
#################This is what the output of parse should be#####################
my $text = "\'Critical\',\'RHSA-2010:0861\',\'Critical: firefox security update\',\'2010-11-10\'";

##########This stuff is preperation to put valid data into the parser###########
open FILE,"<", "t/testFiles/linuxTest.html" or die $!;
my $lines = undef;
while(<FILE>){
	$lines .= $_;
}
close(FILE);
my @args = $linux->Parse($lines);
my $last_arg = $args[-1];
chomp $last_arg;
################################################################################

is ($last_arg,$text,"Parser Test");

$linux->buildPatchList();

my @patch_list = $linux->getPatchList();
my $last_patch = $patch_list[-1];
#Last patch in the list should be this RHSA-2010:0861
is ($last_patch->getID(),'RHSA-2010:0861',"Checks patch list builder and patch list accessor");


#Accessor test methods
is ($linux->createPatch("","RHSA-2010:0861")->getID(), "RHSA-2010:0861", "Test accessor for create Patch (ID)");

is ($linux->createPatch(undef,"ID")->getSeverity(),"N/A", "Negative get test for Create Patch(Severity)");

is ($linux->createPatch("Important","ID")->getSeverity(),"Important", "Test accessor for Create Patch (Severity)");

is ($linux->createPatch("Important","ID")->getDescription(),"N/A", "Negative get test for Create Patch (Description)");

is ($linux->createPatch("","","Synopsis goes here")->getDescription(),"Synopsis goes here", "Test accessor for Create Patch (Description)");

is ($linux->createPatch("Important","ID")->getDate(),"N/A", "Negative get test for Create Patch (Date)");

is ($linux->createPatch("","","","Date here")->getDate(),"Date here", "Test accessor for Create Patch (Date)");

