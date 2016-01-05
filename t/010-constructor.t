#!perl6
use v6;
use lib 'lib';
use Test;

use Audio::SoundTouch;

my $obj;

lives-ok { $obj = Audio::SoundTouch.new }, "create a new Audio::SoundTouch";
isa-ok($obj, Audio::SoundTouch, 'and it is the right sort of object');

diag "Testing with SoundTouch " ~ $obj.version-string;

done-testing;

# vim: expandtab shiftwidth=4 ft=perl6
