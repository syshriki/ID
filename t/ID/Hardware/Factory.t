use strict;
use warnings;
use Data::Dump qw(dump);
use Test::More tests => 19;

use Factory;

can_ok("Factory","new");

###################Data from test.csv###################
#
 #
  my @fileContent = ("name1,url1,support_url1",
	        	"name2,url2,support_url2",
	 		"name3,url3,support_url3");
 #
#
##############Parsed data from test.csv#################
#
 #
  my @parsed1 = ("name1","url1","support_url1");
  my @parsed2 = ("name2","url2","support_url2");
  my @parsed3 = ("name3","url3","support_url3");
 #
#
######Data that should be contained in each vendor######
#
 #
  my $name = "name";
  my $url = "url";
  my $surl = "support url";
 #
#
########################################################



my $factory = new Factory(filename => 'test.csv');
isa_ok ($factory, "Factory" , "make sure we get object from the contructor");

is ($factory->getFileName(), "test.csv", "Test getFileName acessor method");

#There must be a filename in contructor to pass this test
is (new Factory(), undef, "negative test contructor");

#Checks to see if the file content is correct
is ($factory->getFileContent(),@fileContent,"checks content equality");

#Checks to see if the parser has the correct output
is ($factory->parseCSVLine($fileContent[0]),@parsed1, "Checks parser");


my $testVendor = $factory->createVendor($name,$url,$surl);

#Checks createVendor to ensure correct output
is ($testVendor->getName(),$name,"Checks vendor name");
is ($testVendor->getURL(),$url,"Checks vendor URL");
is ($testVendor->getSupportURL(),$surl,"Checks vendor support URL");

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






