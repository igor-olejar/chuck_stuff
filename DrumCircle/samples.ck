// samples.ck

// get global variables
Setup globals;

// instantiate the Drum Maker class
DrumMaker dm;

// get the sequence number from arguments
Std.atoi(me.arg(0)) => int sequence;

// Sound network
Gain g => dac; // main "master" gain

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
    0.1 => g.gain; // resetting the shred's gain, just in case
    timeFrac::globals.quarter => now;
}

fun void playKick(int sequence)
{
    while (true) {
        if (sequence == 1) {
            3.75::globals.quarter => now;
            playSample(kick, 0.5, 0.25);
        } else if (sequence == 2) {
            playSample(kick, 0.5, 2.0);
        } else if (sequence == 3) {
            repeat (2) playSample(kick, 0.5, 0.75);
            playSample(kick, 0.5, 0.5);
        } else {
            playSample(kick, 0.5, 1.0);
        }
    }
}

fun void playSnare(int sequence)
{
    while (true) {
        if (sequence == 1 || sequence == 2) {
            globals.quarter => now;
        } else if (sequence == 3) {
            6::globals.quarter => now;
            
            repeat (2) {
                repeat(2) playSample(snare, 0.7, 0.25);
                0.25::globals.quarter => now;
                playSample(snare, 0.7, 0.25);
            }
        } else {
            repeat(2) playSample(snare, 0.7, 0.5);
            repeat(3) playSample(snare, 0.7, 0.25);
            playSample(snare, 0.6, 0.5);
        }
    }
}

fun void playClap(int sequence)
{
    while (true) {
        if (sequence == 1) {
            globals.quarter => now;
        } else if (sequence == 2) {
            0.5::globals.quarter => now;
            playSample(clap, 0.7, 0.5);
        } else if (sequence == 3) {
            6::globals.quarter => now;
            
            repeat (2) {
                repeat(2) playSample(clap, 0.7, 0.25);
                0.25::globals.quarter => now;
                playSample(clap, 0.7, 0.25);
            }
        } else {
            repeat (2) playSample(clap, 0.7, 0.25);
            0.25::globals.quarter => now;
            repeat (2) playSample(clap, 0.7, 0.25);
            0.25::globals.quarter => now;
            repeat (2) playSample(clap, 0.7, 0.25);
        }
    }
}

spork ~ playKick(sequence);
spork ~ playSnare(sequence);
spork ~ playClap(sequence);

while (true) {
    globals.quarter => now;
}