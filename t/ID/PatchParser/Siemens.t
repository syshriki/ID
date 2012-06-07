use strict;
use warnings;
use Test::More tests => 3;
use ID::PatchParser::Siemens;

can_ok("ID::PatchParser::Siemens","new");
my $fn = "Bulletins/siemens.xls";
my $siemens = new ID::PatchParser::Siemens (FILENAME=>$fn);

isa_ok ($siemens, "ID::PatchParser::Siemens" , "make sure we get object from the contructor");

my @filec = $siemens->parseXLSFile($fn);
my $tfilec = "\'KB816093 \',\'\',\'This update helps resolve a vulnerability in the Microsoft virtual machine. After you install this item, you may have to restart your computer. Once you have installed this item, it cannot be removed. \',\'816093: Security Update Microsoft Virtual Machine (Microsoft VM) \',\'2004-06-08\',\'Test completed \',\'Passed\',\'-\'";

is ($filec[-1],$tfilec,"checks XLS parser");

is($siemens->createPatch("ID","KB","Desc","Prod","Date")->getDate(), "Date", "Tests createPatch (Date)");
is($siemens->createPatch("ID","KB","Desc","Prod","Date")->getID(), "ID", "Tests createPatch (ID)");
is($siemens->createPatch("ID","KB","Desc","Prod","Date")->getAffected(), "Prod", "Tests createPatch (Affected)");
is($siemens->createPatch("ID","KB","Desc","Prod","Date")->getDescription(), "Desc", "Tests createPatch (Description)");
is(@{$siemens->createPatch("ID","KB","Desc","Prod","Date")->getReferences()}, 2, "Tests createPatch (References)");#should only be two references

$siemens->buildPatchList();

my @patch_list  = $siemens->getPatchList();
my $last_patch = @patch_list[-1];
is($last_patch->getID(), "KB816093", "Test for list builder and list getter"); 


