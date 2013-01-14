package mapreduce;

#########################
## Optional helper module
## Report bugs to 
## delip@cs.jhu.edu
#########################

use strict;
use warnings;

sub savehashval {
  my $filename = shift;
  my $href = shift;
  open TMPF, ">$filename" || die "failed opening $filename";
  while (my ($key, $val) = each (%$href)) {
    print TMPF "$key\t$val\n";
  }
  close TMPF;
}

sub savehashvalarray {
  my $filename = shift;
  my $href = shift;
  open TMPF, ">$filename" || die "failed opening $filename";
  while (my ($key, $val) = each (%$href)) {
    my @va = @$val;
    print TMPF "$key\t", join("\t", @va), "\n";
  }
  close TMPF;
}

sub loadhashval {
  my $filename = shift;
  my $href = shift;
  open TMP, "$filename";
  while(<TMP>) {
    chomp;
    my ($key, $val) = split(/\t/, $_);
    $href->{$key} = $val;
  }
  close TMP;
}

sub loadhashvalarray {
  my $filename = shift;
  my $href = shift;
  open TMP, "$filename";
  while(<TMP>) {
    chomp;
    my @val = split(/\t/, $_);
    my $key = shift @val;
    $href->{$key} = \@val;
  }
  close TMP;
}

1;
