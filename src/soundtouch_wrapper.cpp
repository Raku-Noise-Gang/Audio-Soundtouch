// uses C calling convention

typedef float  SAMPLETYPE;
#include <soundtouch/SoundTouch.h>


#ifdef __cplusplus
extern "C" {
#endif

void* soundtouch_new() {
    return new soundtouch::SoundTouch();
}

void soundtouch_free( void* ST_OBJ ) {
    delete static_cast<soundtouch::SoundTouch*>(ST_OBJ);
}

void soundtouch_set_samplerate(void* ST_OBJ , uint rate) {
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setSampleRate(rate);
}

void soundtouch_set_channels(void* ST_OBJ, uint channels) { 
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setChannels(channels);
}

void soundtouch_set_tempo_change(void* ST_OBJ, float tempo ) { 
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setTempoChange(tempo);
}

void soundtouch_set_rate_change(void* ST_OBJ, float rate ) { 
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setRateChange(rate);
}

void soundtouch_set_pitch_semitones(void* ST_OBJ, float pitch) {
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setPitchSemiTones(pitch);
}

BOOL soundtouch_set_setting(void* ST_OBJ, int settingId, int value) { 
	return static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setSetting(settingId, value);
}

void soundtouch_set_rate(void* ST_OBJ, uint rate) {
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setRate(rate);
}

void soundtouch_set_tempo(void* ST_OBJ, float tempo ) { 
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setTempo(tempo);
}

void soundtouch_set_pitch(void* ST_OBJ, float pitch) {
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->setPitch(pitch);
}

void soundtouch_put_samples(void* ST_OBJ, const SAMPLETYPE *samples, uint numSamples ) { 
	static_cast<soundtouch::SoundTouch*>(ST_OBJ)->putSamples(samples, numSamples);
}

uint soundtouch_receive_samples(void* ST_OBJ, SAMPLETYPE *output, uint maxSamples) {
	return static_cast<soundtouch::SoundTouch*>(ST_OBJ)->receiveSamples(output, maxSamples);
}

#ifdef __cplusplus
}
#endif
