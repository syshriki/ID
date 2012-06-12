use warnings;
use strict;
use Config::IniFiles;
use ID::Utilities;

my $OS;

my $cfg = Config::IniFiles->new( -file => "/Configs/bulletins.ini" );

sub load{
	my $OS = shift;

	my $cfg = Config::IniFiles->new( -file => "/Configs/bulletins.ini" );
	my $file = $cfg->val($OS,"file");

	my $HTMLTables = $cfg->val($OS,"tables");
	my $HTMLheaders_section = $cfg->val($OS,"headers");
	my @HTMLHeaders = qw(eval($HTMLHeaders_section));
	my $HTMLHeadersUrl = $cfg->val($OS,"url") $updateFileURL = $cfg->val($OS,"update")

	if(defined $updateFileURL){
		&getWebFile("/Bulletins/$file",$updateFileURL);
	}
	if(defined $file){
		return &parsePatchFile($file);
	}else if(defined @HTMLHeaders && defined $HTMLHeadersURL){
		return &parseHTMLTable($HTMLHeadersURL,/@htmlhEADERS);
	}	
	return "No info found about $OS in Configs/bulletins.ini";
}
