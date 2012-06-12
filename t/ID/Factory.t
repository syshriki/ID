use strict;
use warnings;
use Test::More tests => 17;

use ID::Factory;

can_ok("ID::Factory","new");

#Parsed data from test.csv
my @parsed1 = ("name1","url1","support_url1","parserclass1");
my @parsed2 = ("name2","url2","support_url2","parserclass2");
my @parsed3 = ("name3","url3","support_url3","parserclass3");


my $factory = new ID::Factory(filename => 't/testFiles/testFactory.csv');
isa_ok ($factory, "ID::Factory" , "make sure we get object from the contructor");

is ($factory->getFilename(), "t/testFiles/testFactory.csv", "Test getFileName acessor method");
my $path = 't/testFiles/testFactory.csv';

#There must be a filename in contructor to pass this test
is (new ID::Factory(), undef, "negative test contructor");

my @factorys = $factory->createVendorObjects($factory->getFilename());
#There should be three objects in @built
is(@factorys,3, "Checks createVendorObjects to make sure it contains correct amount of objects");

#Checks the names of each vendor to make sure they are correct
is ($factorys[0]->getName(),$parsed1[0],"Checks name of vendor 1");
is ($factorys[1]->getName(),$parsed2[0],"Checks name of vendor 2");
is ($factorys[2]->getName(),$parsed3[0],"Checks name of vendor 3");

#Checks the url of each vendor
is ($factorys[0]->getURL(),$parsed1[1],"Checks url of vendor 1");
is ($factorys[1]->getURL(),$parsed2[1],"Checks url of vendor 2");
is ($factorys[2]->getURL(),$parsed3[1],"Checks url of vendor 3");

#Checks the support url of each vendor
is ($factorys[0]->getSupportURL(),$parsed1[2],"Checks support URL of vendor 1");
is ($factorys[1]->getSupportURL(),$parsed2[2],"Checks support URL of vendor 2");
is ($factorys[2]->getSupportURL(),$parsed3[2],"Checks support URL of vendor 3");

#Checks the class parser of each vendor
is ($factorys[0]->getParserClass(),$parsed1[3],"Checks class parser of vendor 1");
is ($factorys[1]->getParserClass(),$parsed2[3],"Checks class parser of vendor 2");
is ($factorys[2]->getParserClass(),$parsed3[3],"Checks class parser of vendor 3");
