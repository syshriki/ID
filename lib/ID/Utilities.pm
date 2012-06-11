package ID::Utilities;
use warnings;
use strict;
use Text::CSV_XS;
use Spreadsheet::ParseExcel;
use File::Basename;
use HTML::TableExtract;
use LWP::UserAgent;

sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {@_};
    bless ( $self, $class );
    return $self;
}

sub addDelimiters{
	my $self = shift;
	my $curr_array = shift;
	my @new_array = ();
	my @temp_row = ();
	my $del_char = ',';
	foreach my $row(@$curr_array){
		foreach my $cell(@$row){
			push(@temp_row,"\'$cell\',");
		}
		chop ($temp_row[-1]);		#removes comma at end since there is no element after [-1]
		push(@new_array,[@temp_row]);
		@temp_row = ();
	}
	return @new_array;
}
sub parsePatchFile{
	my $self = shift;
	my $fn = shift;
	my $delimit = shift;
	my $ext = substr((fileparse("$fn", qr/\.[^.]*/))[2],1); #get file extension of file
	$ext =~ tr/[a-z]/[A-Z]/; 			#makes the file extension into all upper case letters
	my $parser_sub = ("parse" . $ext . "File");
	if (!defined &{"$parser_sub"}){
		return "No parser found to parse $ext files.\n";
	}
	my @data = eval'$self->'.'$parser_sub'.'($fn)';
	if($delimit){					#Auto delimit
		@data = addDelimiters(@data);
	}
	return @data;
}

sub parseCSVFile{
	my $self = shift;
  	my $configFile = shift;
	my $csv = Text::CSV_XS->new ({ keep_meta_info => 1, binary => 1 });
	my @arg_list = ();
	my @parsed_csv_data = ();
	my @columns = $csv->fields();
        open my $FH, "<", "$configFile" or die $!;
        while(my $fetchline = <$FH>){
		my @arg_list = ();
		if ($csv->parse($fetchline)){
			@columns = $csv->fields();
			foreach my $arg(@columns){
				push(@arg_list,"$arg");
			}
			push( @parsed_csv_data, [@arg_list] );
		} else {
			 my $err = $csv->error_input;
                	 print "Failed to parse line: $err";
		}
        }
        close $FH;
	return @parsed_csv_data;
}

sub parseHTMLTable{
	my $self = shift;
	my $url = shift;
	my $headers = shift;
	my $te = HTML::TableExtract->new( headers => [@$headers] );
	my $ua = LWP::UserAgent->new;
	my @row_args = ();
	my @table_args = ();
	my $html_code;
	
	my $response = $ua->get("$url");
	if ($response->is_success) {
		$html_code = $response->decoded_content;
	}
    else{
		print ($response->status_line."\n$url is bad");
		return 0;
    }
    $te->parse($html_code);
    foreach my $ts($te->tables){
    	foreach my $row ($ts->rows){
    		foreach my $cell(@$row){
        		push(@row_args,$cell);
        	}
        	push(@table_args,[@row_args]);
        	@row_args = ();
        }
    }
    return @table_args;
}

sub parseXLSFile {
    my $self = shift;
    my $fn = shift;
    my @parsedData;
    my $xls = Spreadsheet::ParseExcel->new;
    my $workbook = $xls->parse($fn);
    if ( !defined $workbook ) {
	 die $xls->error(), ".\n";
    }
    for my $worksheet ( $workbook->worksheets() ) {
        my ( $row_min, $row_max ) = $worksheet->row_range();
        my ( $col_min, $col_max ) = $worksheet->col_range();
        for my $row ( $row_min..$row_max ) {
    		my @temp = ();
        	for my $col ( $col_min..$col_max ) {
                	my $cell = $worksheet->get_cell( $row, $col );
                	my $cellContents = $cell->value;
  			$cellContents =~ s/^\s+//; #Remove leading whitespace
          		$cellContents =~ s/\s+$//; #Remove
                	$cellContents =~ s/\s+$//; #Remove trailing whitespace
                	push ( @temp, $cellContents );
            	}
     		push ( @parsedData, [@temp] ); #Push parsed row array into data array
        }
    }
    return @parsedData;
}

sub getWebFile{
    my $self = shift;
    my ( $fn,$URL ) = @_;
    my $ua = LWP::UserAgent->new;
        $ua->timeout(10);
    my $response = $ua->get( $URL, ':content_file' => $fn );
    if ( $response->is_success ) {
        return $fn;
    } else {
        die $response->status_line;
    }
}
1;
