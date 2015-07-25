#!perl6

use v6;

use Panda::Common;
use Panda::Builder;
use LibraryMake;
use Shell::Command;
use LibraryCheck;

class Build is Panda::Builder {
    method build($workdir) {
        if !library-exists('libSoundTouch') {
            say "no soundtouch library";
            die "no libSoundTouch - won't build";
        }
        else {
            mkpath "$workdir/blib/lib";
            make("$workdir/src", "$workdir/blib/lib");
        }
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
