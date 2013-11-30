#! /usr/bin/perl
BEGIN{
        use Cwd;
        my $cwd=cwd;
        push @INC, "$cwd/perl_modules";
}
#####################################################

use 5.010;
use Getopt::Long;
use read_fasta;
use parse_blast_output;
use strict;

my ($cds_file, $pep_file, $blast_output, $e_value, $seperator);
my (%seq, $seq_href, $tmp_seq_href, $rela_blast_result_AND_subject_range_href);

GetOptions(
        'cds_file=s'                =>        \$cds_file,
        'pep_file=s'                =>        \$pep_file,
        'blast_output=s'        =>        \$blast_output,
        'seperator=s'                =>        \$seperator,
        'e_value=s'                =>        \$e_value,
) || (&show_help and die "illegal parameters\n");

$seperator = "\t" if not $seperator;
$e_value = 1e-10 if not $e_value;
&show_help if not ($cds_file and $pep_file and $blast_output);

########################################################################

$tmp_seq_href = &read_fasta::read_fasta($cds_file);
        @{$seq{'cds'}}{keys %$tmp_seq_href} = values %$tmp_seq_href;
$tmp_seq_href = &read_fasta::read_fasta($pep_file);
        @{$seq{'pep'}}{keys %$tmp_seq_href} = values %$tmp_seq_href;
        #foreach (values %{$seq{'cds'}}){print $_."\n";}

$rela_blast_result_AND_subject_range_href = &parse_blast_output::parse_blast_output($blast_output, $e_value, $seperator);

my $blast_output_k=1;
open (my $IN, '<', "$blast_output");
while(my $line=<$IN>){
        $line =~ s/[\r\n]*$//g;
        $line =~ s/\,/\t/g;
        if (exists $rela_blast_result_AND_subject_range_href->{$blast_output_k}){
                my ($subject_name, $subject_range) =
                        @{$rela_blast_result_AND_subject_range_href->{$blast_output_k}}{'subject_name', 'subject_range'};
                #my (%tmp_seq);
                #map {$tmp_seq{$_} = $seq{$_}{$subject_name}} qw(cds pep);
                my ($start, $end) = split /\-/, $subject_range;
                my $pep = substr ($seq{'pep'}{$subject_name}, $start-1, $end-$start+1);
                my $cds = substr ($seq{'cds'}{$subject_name}, 3*($start-1), 3*($end-$start+1));
                print join ("\t", ($line, $start, $end, $pep, $cds));
        }
        else{
                print $line;
        }
        print "\n";
        $blast_output_k++;
}

########################################################################
sub show_help{
        print "USAGE:\tperl $0 ";
        print <<EOF
<-cds_file cds_file> <-pep_file pep_file> <-blast_output blast_output>
        Options:
                -e_value        e_value_cutoff        default: 1e-10
                -seperator        seperator to seperate the blast output file
                                        default:        comma
EOF
        ;
exit;
}
