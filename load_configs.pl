use warnings;
use strict;
use Config::IniFiles;
use ID::Utilities;

sub load{
	my $OS = shift;

	my $utils = new ID::Utilities;
	my $cfg = Config::IniFiles->new( -file => "Configs/bulletins.ini" );
	my $file = $cfg->val($OS,"file");

	my $HTMLTables = $cfg->val($OS,"tables");
	my $HTMLHeaders_section = $cfg->val($OS,"headers");
	my @HTMLHeaders = qw(eval($HTMLHeaders_section));
	my $HTMLHeadersUrl = $cfg->val($OS,"url"); 
	my $updateFileURL = $cfg->val($OS,"update");

	if(defined $updateFileURL){
		$utils->getWebFile("/Bulletins/$file",$updateFileURL);
	}
	if(defined $file){
		return $utils->parsePatchFile($file);
	}
	else{
		if(defined $HTMLHeaders[0] && $HTMLHeadersUrl){
			return $utils->parseHTMLTable($HTMLHeadersUrl,[@HTMLHeaders]);
		}
	}
	return ('Missing info from Configs bulletins ini for $OS');
}1;

