#! /usr/bin/perl

package parse_blast_output;

require Exporter;
use strict;

sub parse_blast_output {
	my ($blast_k, %return);
	my ($blast_output_file, $e_value_cutoff, $seperator) = @_;
	$seperator = "\t" if not $seperator;
	open (my $IN, '<', "$blast_output_file") || die "blast output file $blast_output_file cannot be opened!\n";
	while(<$IN>){
		chomp;
		my ($query, $subject, $identity,
			$ali_length, $num_of_mismatch, $num_of_gap_open, 
			$query_start, $query_end, $subject_start, $subject_end,
			$e_value, $bit_score) 
		= split /$seperator/;
		$blast_k++;
		next if $e_value > $e_value_cutoff;
		$return{$blast_k}{'subject_range'} = $subject_start.'-'.$subject_end;
		$return{$blast_k}{'subject_name'}  = $subject;
		#print $subject."\n";
	}
	return (\%return);
}


