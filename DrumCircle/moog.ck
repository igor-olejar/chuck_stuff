// moog.ck

// get global variables
Setup globals;

// get the sequence number from arguments
Std.atoi(me.arg(0)) => int sequence;

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
    if (sequence == 1) {
        globals.quarter => now;
    } else if (sequence == 2) {
        7.5::globals.quarter => now;
        playMoog(0.3, 7, 0.5);
    } else if (sequence == 3) {
        playMoog(0.3, 0, 0.75);
        playMoog(0.3, 1, 0.25);
        playMoog(0.0, 0, 0.5);
        playMoog(0.3, 2, 0.5);
    } else if (sequence == 4) {
        repeat (2) playMoog(0.3, 0, 0.666);
        playMoog(0.3, 1, 0.666);
        
        repeat (2) playMoog(0.3, 0, 0.666);
        playMoog(0.3, 2, 0.666);
        
        repeat (2) playMoog(0.3, 0, 0.666);
        playMoog(0.3, 3, 0.666);
        
        repeat (2) playMoog(0.3, 0, 0.666);
        playMoog(0.3, 4, 0.666);
    } else {
        playMoog(0.5, 0, 4);
    }
}