package ID::Factory;
use strict;
use warnings;
use Text::CSV_XS;
use ID::Hardware::Vendor;
use ID::Utilities;
#Contructor
#Notes: Requires a csv file name as input 
sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {@_};

    bless ( $self, $class );

    if ( ! defined $self->getFilename() ) {
                 return;
    }

    return $self;
}
#Accessor method for Filename
sub getFilename{
        my $self = shift;
        my $fn = $self->{filename};
        return $fn;
}

#Description: Creates the vendor patch objects
#Arguments: Filename
#Returns: List of Vendor Objects
sub createVendorObjects{
        my $self = shift;
        my $fn = shift;

        my $utils = new ID::Utilities;
        my @vendorData = $utils->parsePatchFile($fn);

        my @vendorObjects = ();
        my ($vendor_name,$url,$supportURL,$cparse,$vendor) = undef;

        foreach my $v( @vendorData ){
                $vendor_name = shift @$v;
                $vendor = new ID::Hardware::Vendor(Name => $vendor_name);
                $url = shift @$v;
                $supportURL = shift @$v;
                $cparse = shift @$v;
                $vendor->setURL($url);
                $vendor->setSupportURL($supportURL);
                $vendor->setParserClass($cparse);
                push(@vendorObjects,$vendor);
        }
        return @vendorObjects;
}
1;

