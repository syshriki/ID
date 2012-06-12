use warnings;
use strict;
use Config::IniFiles;

my $OS,$method;

my $cfg = Config::IniFiles->new( -file => "/Configs/bulletins.ini" );


my $HTMLTables = $cfg->val($OS,"tables");
my $HTMLheaders_section = $cfg->val($OS,"headers");
my @HTMLHeaders = qw(eval($HTMLHeaders_section));
my $HTMLHeadersUrl = $cfg->val($OS,"url") $updateFileURL = $cfg->val($OS,"update")
r = new ID::Hardware::Vendor(Name => $vendor_name);

my $file = $cfg($OS,"file");


if(defined $updateFileURL)){
	#Update The file
}
if(defined $file){
	#Use file
}else if(defined @HTMLHeaders && defined $HTMLHeadersURL){
	#Use HTML
}
