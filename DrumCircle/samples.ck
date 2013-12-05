// samples.ck

Setup globals;

DrumMaker dm;

// kick
dm.makeDrum("kick_01.wav", 0.2) @=> SndBuf kick => dac;

// snare
dm.makeDrum("snare_01.wav", 0.2) @=> SndBuf snare => dac;

// clap
dm.makeDrum("clap_01.wav", 0.2) @=> SndBuf clap => dac;

kick.samples() => kick.pos;
snare.samples() => snare.pos;
clap.samples() => clap.pos;

fun void playSample(SndBuf instrument, float velocity, float timeFrac)
{
    0 => instrument.pos;
    velocity => instrument.gain;
    timeFrac::globals.quarter => now;
}

fun void playKick(int sequence)
{
    while (true) {
        
    }
}

fun void playSnare(int sequence)
{
    while (true) {
    
    }
}

fun void playClap(int sequence)
{
    while (true) {
    
    }
}

spork ~ playKick();
spork ~ playSnare();
spork ~ playClap();

while (true) {
    globals.quarter => now;
}