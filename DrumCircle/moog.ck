// moog.ck

Setup globals;

// Moog instance
Moog m => Gain g => dac;

fun void playMoog(float velocity, int note, float timeFrac)
{
    Std.mtof(globals.midi_notes[note]-12) => m.freq;
    velocity => m.noteOn;
    0.3 => g.gain;
    
    timeFrac::globals.quarter => now;
    
    1 => m.noteOff;
}

while (true) {
    playMoog(0.3, 0, 0.666);
}