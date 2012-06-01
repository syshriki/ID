use strict;
use warnings;
use Data::Dump qw(dump);
use Test::More tests => 23;

use ID::Factory;
 
can_ok("ID::Factory","new");

###################Data from test.csv###################
#
 #
  my @fileContent = ("name1,url1,support_url1,clasparser1",
	        	"name2,url2,support_url2,classparser2",
	 		"name3,url3,supprt_url3,classparser3");
 #
#
##############Parsed data from test.csv#################
#
 #
  my @parsed1 = ("name1","url1","support_url1","parserclass1");
  my @parsed2 = ("name2","url2","support_url2","parserclass2");
  my @parsed3 = ("name3","url3","support_url3","parserclass3");
 #
#
######Data that should be contained in each vendor######
#
 #
  my $name = "name";
  my $url = "url";
  my $surl = "support url";
  my $cparser = "class parser";
 #
#
########################################################


my $factory = new ID::Factory(filename => 'test.csv');
isa_ok ($factory, "ID::Factory" , "make sure we get object from the contructor");

is ($factory->getFileName(), "test.csv", "Test getFileName acessor method");

#There must be a filename in contructor to pass this test
is (new ID::Factory(), undef, "negative test contructor");

#Checks to see if the file content is correct
is ($factory->getFileContent(),@fileContent,"checks content equality");

#Checks to see if the parser has the correct output
is ($factory->parseCSVLine($fileContent[0]),@parsed1, "Checks parser");


my $testVendor = $factory->createVendor($name,$url,$surl,$cparser);

#Checks createVendor to ensure correct output
is ($testVendor->getName(),$name,"Checks vendor name");
is ($testVendor->getURL(),$url,"Checks vendor URL");
is ($testVendor->getSupportURL(),$surl,"Checks vendor support URL");
is ($testVendor->getParserClass(),$cparser,"Checks vendor class parser");

my @built = $factory->buildVendorList();
 
#There should be three objects in @built
is(scalar @built,3, "Checks buildVendorList count");

#Checks the names of each vendor to make sure they are correct
is ($built[0]->getName(),$parsed1[0],"Checks name of vendor 1");
is ($built[1]->getName(),$parsed2[0],"Checks name of vendor 2");
is ($built[2]->getName(),$parsed3[0],"Checks name of vendor 3");

#Checks the url of each vendor
is ($built[0]->getURL(),$parsed1[1],"Checks url of vendor 1");
is ($built[1]->getURL(),$parsed2[1],"Checks url of vendor 2");
is ($built[2]->getURL(),$parsed3[1],"Checks url of vendor 3");

#Checks the support url of each vendor
is ($built[0]->getSupportURL(),$parsed1[2],"Checks support URL of vendor 1");
is ($built[1]->getSupportURL(),$parsed2[2],"Checks support URL of vendor 2");
is ($built[2]->getSupportURL(),$parsed3[2],"Checks support URL of vendor 3");

#Checks the class parser of each vendor
is ($built[0]->getParserClass(),$parsed1[3],"Checks class parser of vendor 1");
is ($built[1]->getParserClass(),$parsed2[3],"Checks class parser of vendor 2");
is ($built[2]->getParserClass(),$parsed3[3],"Checks class parser of vendor 3");





