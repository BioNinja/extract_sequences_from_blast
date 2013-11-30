#! /usr/bin/perl

use strict;

package read_fasta;
require Exporter;

sub read_fasta{
	my ($fasta_file) = @_;
	open (my $IN, '<', "$fasta_file") || die "fasta file $fasta_file cannot be opened";
	my @file = <$IN>;
	my ($title, $seq, %seq);
	foreach (@file){
		my $seq;
		chomp;
		if (/^\s+/){
			next;
		}
		elsif (/^\#/){
			next;
		}
		elsif (/^>(.+)/){
			$title = $1;
			$seq{$title} = '';
		}
		else{
			$seq = $_;
			$seq{$title} .= $seq;
		}
	}
	return (\%seq);
}



