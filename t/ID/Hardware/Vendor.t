#
#===============================================================================
#
#         FILE:  Vendor.t
#
#  DESCRIPTION:  Unit tests for ID::Hardware::Vendor
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Philip Foster (pfoster), pfoster@industrialdefender.com
#      COMPANY:  Industrial Defender
#      VERSION:  1.0
#      CREATED:  05/23/2012 08:55:22 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use Test::More tests => 8;

use ID::Hardware::Vendor;

can_ok ( "ID::Hardware::Vendor", "new" );

# Create an object of type ID::Hardwar::Vendor
my $vendorName = "ABB";
my $vendor = new ID::Hardware::Vendor ( Name => $vendorName );

# Make sure the object is of the correct type
isa_ok ( $vendor, "ID::Hardware::Vendor", "make sure we go an object from the constructor" );

# Test getName() accessor method
is ( $vendor->getName(), $vendorName, "test getName() accessor method returns the vendor name" );

# Try to create an object without passing in a Name to the constructor
is ( new ID::Hardware::Vendor(), undef, "negative test constructor, it should return null if 'Name' is not defined" );

# Test URL accessor methods
my $vendorURL = "http://www.abb.com";
is ( $vendor->getURL(), undef, "getURL should return undef until a URL is set" );
$vendor->setURL ( $vendorURL );
is ( $vendor->getURL(), $vendorURL, "test URL accessor methods" );

# Test SupportURL accessor methods
my $vendorSupportURL = "http://www.abb.com/ProductGuide";
is ( $vendor->getSupportURL(), undef, "getSupportURL should return undef until a SupportURL is set" );
$vendor->setSupportURL ( $vendorSupportURL );
is ( $vendor->getSupportURL(), $vendorSupportURL, "test SupportURL accessor methods" );


