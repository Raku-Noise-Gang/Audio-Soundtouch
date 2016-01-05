use v6;


class Audio::SoundTouch {
    use NativeCall;

    constant LIB = "SoundTouch", v1; 

    class FIFOSamplePipe is repr('CPPStruct') {
    }

    class FIFOProcessor is FIFOSamplePipe is repr('CPPStruct') {
        has FIFOSamplePipe $.output;
    }

    class SoundTouch is FIFOProcessor is repr('CPPStruct') {

        # need this for the missing 8 bytes;
        has Pointer $!vtable; 

        method new() is nativeconv('thisgnu') is symbol('soundtouch::SoundTouch::new') is native(LIB) { * }
        method version-string() returns Str is encoded('ascii') is symbol('soundtouch::SoundTouch::getVersionString') is native(LIB) { * }

        method version-id() returns uint32 is symbol('soundtouch::SoundTouch::getVersionId') is native(LIB) { * }

        # Privates'

        has Pointer $.pRateTransposer;
        has Pointer $.pTDStretch;
        has num32   $.virtualRate;
        has num32   $.virtualTempo;
        has num32   $.virtualPitch;
        has int32   $.bSrateSet;

        # Protected

        has uint32  $.channels;
        has num32   $.rate;
        has num32   $.tempo;
    }

    has SoundTouch $!touch handles <version-string version-id>;

    multi submethod BUILD(*%params) {
        $!touch = SoundTouch.new();
    }

}

# vim: expandtab shiftwidth=4 ft=perl6
