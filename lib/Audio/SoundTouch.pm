use v6;


class Audio::SoundTouch {
    use NativeCall;

    constant LIB = "SoundTouch", v1; 

    constant CPP-NS = "soundtouch";

    multi sub trait_mod:<is> ( Routine $r, Str :$cpp-symbol!) {
        my $name = CPP-NS ~ '::' ~ $r.package.^shortname ~ '::' ~ $cpp-symbol;
        trait_mod:<is>($r, symbol => $name);
    }

    class FIFOSamplePipe is repr('CPPStruct') {
    }

    class FIFOProcessor is FIFOSamplePipe is repr('CPPStruct') {

        multi method receive-samples(CArray[num32] $samples, uint32 $numSamples) returns uint32 is cpp-symbol('receiveSamples') is native(LIB) { * }
        multi method receive-samples(uint32 $numSamples) returns uint32 is cpp-symbol('receiveSamples') is native(LIB) { * }

        method num-samples() returns uint32 is cpp-symbol('numSamples') is native(LIB) { * }

        method is-empty() returns int32 is cpp-symbol('isEmpty') is native(LIB) { * }

        # Protected
        has FIFOSamplePipe $.output;
    }

    class SoundTouch is FIFOProcessor is repr('CPPStruct') {

        # need this for the missing 8 bytes;
        has Pointer $!vtable; 

        method new() is nativeconv('thisgnu') is cpp-symbol('new') is native(LIB) { * }
        method version-string() returns Str is cpp-symbol('getVersionString') is native(LIB) { * }

        method version-id() returns uint32 is cpp-symbol('getVersionId') is native(LIB) { * }

        method set-rate(num32 $newRate) is cpp-symbol('setRate') is native(LIB) { * }
        method set-tempo(num32 $newTempo) is cpp-symbol('setTempo') is native(LIB) { * }
        method set-rate-change(num32 $newRate) is cpp-symbol('setRateChange') is native(LIB) { * }
        method set-tempo-change(num32 $newTempo) is cpp-symbol('setTempoChange') is native(LIB) { * }

        method set-pitch(num32 $newPitch) is cpp-symbol('setPitch') is native(LIB) { * }
        method set-pitch-octaves(num32 $newPitch) is cpp-symbol('setPitchOctaves') is native(LIB) { * }
        multi method set-pitch-semitones(int32 $newPitch) is cpp-symbol('setPitchSemiTones') is native(LIB) { * }
        multi method set-pitch-semitones(num32 $newPitch) is cpp-symbol('setPitchSemiTones') is native(LIB) { * }

        method set-channels(uint32 $numChannels) is cpp-symbol('setChannels') is native(LIB) { * }
        method set-samplerate(uint32 $srate) is cpp-symbol('setSampleRate') is native(LIB) { * }

        method void() is cpp-symbol('void') is native(LIB) { * }

        method put-samples(CArray[num32] $samples, uint32 $numSamples) is cpp-symbol('putSamples') is native(LIB) { * }


        method clear() is cpp-symbol('clear') is native(LIB) { * }

        method set-setting(int32 $setting, int32 $value) returns int32 is cpp-symbol('setSetting') is native(LIB) { * }
        method get-setting(int32 $setting) returns int32 is cpp-symbol('getSetting') is native(LIB) { * }

        method unprocessed-samples() returns uint32 is cpp-symbol('numUnprocessedSamples') is native(LIB) { * }





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

    multi submethod BUILD(Int :$samplerate = 44100, :$channels = 2, *%params) {
        $!touch = SoundTouch.new();
        $!touch.set-samplerate($samplerate);
        $!touch.set-channels($channels);
    }

}

# vim: expandtab shiftwidth=4 ft=perl6
