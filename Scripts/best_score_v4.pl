#!/usr/bin/perl

=pod

=head1 NAME
best_score.pl

=head1 SYNOPSIS

Returns the list best hits from a list of BLAST results.

=head1 DESCRIPTION

The number of matches returned by standalone BLAST, even with -v 1 -b 1 option, depends for each query. In some cases, it is desired to output just one best hit result (according to the bit score and evalue).

The input file is openened twice, such that memory footprint is kept minimal.
The first operation/loop records for each query, the BLAST result with the best e-value.
The second operation/loop scans again through the file and outputs complete BLAST results for the lowest e-value hit.
 
=head1 BUGS/CAVEATS

File opens twice, but only to record as few hits as possible.

=head1 AUTHOR

Mathias Vandenbogaert

Pole Genotypage des Pathogenes,
Cellule d'Intervention Biologique d'Urgence (CIBU),
CCOMS  de Reference et de Recherche pour les Arbovirus et les Fievres hemorragiques virales,
Unite de Recherche et d'Expertise 'Environnement et Risques Infectieux' (ERI).

Institut Pasteur,
25-28 rue du docteur Roux,
75015 Paris

=head1 SEE ALSO

=head1 COPYRIGHT and LICENSE


=cut

use strict;
use warnings;
use Getopt::Long;

my $infile;
my $outfile;

GetOptions(
    "i=s" => \$infile,
    "o|outputFolder=s" => \$outfile,
    );

if(!defined($infile)) {
    prtError("No input files are provided");
}

open(INFILE, "<$infile") || die "$infile non trouvé\n";
open(OUTFILE, ">$outfile") || die "$outfile non trouvé\n";

my %hash;
while (<INFILE>) {
    my $line = $_;
    $line =~ s/\n//g;
    $line =~ s/\r//g;
    my @param = split (/\t/,$line);
    if (!(defined($hash{$param[0]}))){
	$hash{$param[0]}=$param[11];
#	print "INIT hashing $param[0] with $param[11]" . "\n";
    }
    else{
	if ($hash{$param[0]} < $param[11]) {
	    $hash{$param[0]}=$param[11];
#	    print "hashing $param[0] with $param[11]" . "\n";
	}
    }
}
close (INFILE);

# system("cat $infile | strings | sort -o $infile.sorted");

open(INFILE, "<$infile") || die "$infile non trouvé\n";
while (<INFILE>) {
    my $line = $_;
    $line =~ s/\n//g;
    $line =~ s/\r//g;
    my @param = split (/\t/,$line);
    if (defined $param[0]) {
	if ($param[11] == $hash{$param[0]}) {
	    print OUTFILE "$line\n";
	}
    }
}
close (INFILE);
close (OUTFILE);

