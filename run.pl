use ID::Factory;
use ID::PatchParser::ABB;
use ID::PatchParser;
use ID::Patch;
use ID::Hardware::Vendor;
use strict;
use warnings;

my $factory = new ID::Factory(filename => 'test.csv');
$factory->buildVendorList();
my @vendors = $factory->getVendorList();
my @parsers = ();
foreach my $v(@vendors){
	push(@parsers,makePatchParser($v));
}

sub makePatchParser{
	my $vendor = shift;
	my $module = 'ID::PatchParser::'.$vendor->getParserClass();
                eval "require $module";
	return new $module ( Unparsed => $vendor->getURL());
} 


	



