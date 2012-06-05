package ID::Factory;
use strict;
use warnings;
use Text::CSV_XS;
use ID::Hardware::Vendor;

#Contructor
#Notes: Requires a csv file name as input 
sub new {
    my ( $invocant ) = shift;
    my ( $class ) = ref ( $invocant ) || $invocant;
    my ( $self ) = {@_};
    $self->{vendor_list} = ();
    
    bless ( $self, $class );

    if ( ! defined $self->getFileName() ) {
                 return;
    }

    return $self;
}

#Accessor method for the vendor list
sub getVendorList{
        my $self = shift;
        return @{$self->{vendor_list}};
}

#Builds the list of Vendor objects from the CSV file
#Arguments: None
#Returns: List of Vendors
sub buildVendorList{
        my $self = shift;
        my @vendor_list = ();
        my @args = ();
        my @file_content = $self->getFileContent($self->getFileName());
        foreach my $line(@file_content){
                @args = $self->parseCSVLine($line);
                push(@vendor_list,$self->createVendor($args[0],$args[1],$args[2],$args[3]));
        }
        @{$self->{vendor_list}} = @vendor_list;
}

#Gets the name of the csv file
#Arguments: None
#Returns: csv filename
sub getFileName{
        my $self = shift;
        my $fn = $self->{filename};
        return  $fn;
}

#Reads the contents of a file into an array line by line
#Arguments: None
#Returns: File content in array
sub getFileContent{
        my $self = shift;
        my $configFile = shift;
        my @file_content = ();
        open my $FH, "<", "$configFile" or die $!;
        while(my $fetchline = <$FH>){
                push(@file_content,"$fetchline");
        }
        close $FH;
        return @file_content;
}

#Parses lines of text in csv format and puts them into a useable format
#Arguments: Line of text as scalar to be parsed
#Returns: Parsed data in array 
sub parseCSVLine{
        my $self = shift;
        my $input_string = shift;
        my @arg_list = ();
        my $csv = Text::CSV_XS->new ({ keep_meta_info => 1, binary => 1 });

        if ($csv->parse($input_string)){
                my @columns = $csv->fields();
                foreach my $arg(@columns){
                        push(@arg_list,"$arg");
                }
        } else {
            my $err = $csv->error_input;
            print "Failed to parse line: $err";
        }
        return @arg_list;
}
#Takes in vendor information and uses it to create a Vendor object
#Arguments: Vendor name, Vendor URL, Support URL, Parser Class all scalars
#Returns: Vendor object
sub createVendor{
        my $self = shift;
        my $vendor_name = shift;
        my $url = shift;
        my $supportURL = shift;
        my $cparse = shift;
        my $vendor = new ID::Hardware::Vendor(Name => $vendor_name);
        $vendor->setURL($url);
        $vendor->setSupportURL($supportURL);
        $vendor->setParserClass($cparse);
        return $vendor;
}
1;
