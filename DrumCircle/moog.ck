// moog.ck

Setup globals;

// Moog instance
Moog m => dac;

fun void playMoog(float velocity, float note, float timeFrac)
{
    Std.mtof(globals.notes[note]) => m.freq;
    velocity => m.noteOn;
    
    timeFrac::globals.quarter => now;
    
    1 => m.noteOff;
}

while (true) {
    playMoog(0.3, 0, 1.0);
}