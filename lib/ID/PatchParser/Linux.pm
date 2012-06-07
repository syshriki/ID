package ID::PatchParser::Linux;
use strict;
use warnings;
require 'ID/PatchParser/Scripts/getHTML.pl';
use HTML::TableExtract;
use base 'ID::PatchParser';
use ID::Patch;

sub getPatchList{
        my $self = shift;
        return @{$self->{patch_list}};
}

sub buildPatchList()
{
	my $self = shift;
	setConfigFile($self->getFilename());
	my @html_data = &scrape();
	my @patch_list = ();
	my @args = ();
	foreach my $site_code(@html_data){
		@args = $self->Parse($site_code);
		foreach my $patch(@args){
			push(@patch_list,$self->createPatch(eval($patch)));
		}
	}
	@{$self->{patch_list}} = @patch_list;	
}

sub Parse{
	my $self = shift;
	my $html_code = shift;
        my $te = HTML::TableExtract->new( headers => [qw(Severity Advisory Synopsis Date)] );
        my @args = ();
        $te->parse($html_code);
        foreach my $ts($te->tables) {
               foreach my $row ($ts->rows) {
                       push(@args,("\'".join('\',\'',@$row)."\'\n"));
               }
        }
        return @args;
}

sub createPatch{
	my $self = shift;
	my ($severity,$advisory,$synopsis,$date) = @_;
	my $patch = new ID::Patch(ID => $advisory);
	$patch->setSeverity($severity);
	$patch->setDescription($synopsis);
	$patch->setDate($date);
	return $patch;
}
1;
