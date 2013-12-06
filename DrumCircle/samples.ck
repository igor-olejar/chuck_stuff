// samples.ck

Setup globals;

DrumMaker dm;

// Sound network
Gain g => dac;
// kick
dm.makeDrum("kick_04.wav", 0.2) @=> SndBuf kick => g;

// snare
dm.makeDrum("snare_03.wav", 0.2) @=> SndBuf snare => g;

// cowbell
dm.makeDrum("cowbell_01.wav", 0.2) @=> SndBuf clap => g;

kick.samples() => kick.pos;
snare.samples() => snare.pos;
clap.samples() => clap.pos;

fun void playSample(SndBuf instrument, float velocity, float timeFrac)
{
    0 => instrument.pos;
    velocity => instrument.gain;
    0.1 => g.gain;
    timeFrac::globals.quarter => now;
}

fun void playKick(int sequence)
{
    while (true) {
        playSample(kick, 0.5, 2.0);
    }
}

fun void playSnare(int sequence)
{
    while (true) {
        repeat(2) playSample(snare, 0.7, 0.5);
        repeat(3) playSample(snare, 0.7, 0.25);
        playSample(snare, 0.6, 0.5);
    }
}

fun void playClap(int sequence)
{
    while (true) {
        globals.quarter => now;
    }
}

spork ~ playKick(0);
spork ~ playSnare(0);
spork ~ playClap(0);

while (true) {
    globals.quarter => now;
}