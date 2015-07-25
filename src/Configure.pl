#!perl6

use v6;

use LibraryMake;

my $destdir = '../lib';
my %vars = get-vars($destdir);
say %vars<LIBS>.perl;
process-makefile('src', %vars);
make('src', $destdir);
# vim: expandtab shiftwidth=4 ft=perl6
