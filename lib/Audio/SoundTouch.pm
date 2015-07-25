use v6;


class Audio::SoundTouch {
    use LibraryMake;
    use NativeCall;

    sub library {
        my $so = get-vars('')<SO>;
        my $libname = "soundtouch_wrapper$so";
        my $base = "lib/Sys/Lastlog/$libname";
        for @*INC <-> $v {
            if $v ~~ Str {
                $v ~~ s/^.*\#//;
                if ($v ~ '/' ~ $libname).IO.r {
                    return $v ~ '/' ~ $libname;
                }
            }
            else {
                if my @files = ($v.files($base) || $v.files("blib/$base")) {
                    my $files = @files[0]<files>;
                    my $tmp = $files{$base} || $files{"blib/$base"};

                    $tmp.IO.copy($*SPEC.tmpdir ~ '/' ~ $libname);
                    return $*SPEC.tmpdir ~ '/' ~ $libname;
                }
            }
        }
        die "Unable to find library";
    }

    class Touch is repr('CPointer') {

        sub soundtouch_new() returns Touch is native(&library) { * }

        method new(*%params) {
            soundtouch_new();
        }

        sub soundtouch_free(Touch) is native(&library) { * }

        method DESTROY() {
            soundtouch_free(self);
        }

    }

    has Touch $!touch;

    multi submethod BUILD(*%params) {
        $!touch = Touch.new(|%params);
    }

}

# vim: expandtab shiftwidth=4 ft=perl6
