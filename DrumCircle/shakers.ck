// shakers.ck

// set up global variables
Setup globals;

// make an instance of the Shaker Maker class
ShakerMaker sm;

// get the sequence number from arguments
Std.atoi(me.arg(0)) => int sequence;

// Sound network
sm.makeShaker(7, 0.9, 20.0) @=> Shakers bell => Pan2 bell_pan => dac; // sleigh bell
sm.makeShaker(15, 0.9, 20.0) @=> Shakers mug => Pan2 mug_pan => dac; // mug

0.4 => bell_pan.gain => mug_pan.gain; // overall gain, just before going to dac

-0.8 => bell_pan.pan; // pan for the bell object
0.8 => mug_pan.pan; // pan for the mug object

// function that simply plays the sound, given the instrument, velocity and time fraction
fun void playShaker(Shakers instrument, float velocity, float timeFrac)
{
    velocity => instrument.noteOn;
    0.3 => bell_pan.gain => mug_pan.gain; // set the overall gain again, just to make sure there's no clippint
    
    // advance time
    timeFrac::globals.quarter => now;
    
    // turn the sound off
    velocity => instrument.noteOff;
}

// play the bell sound according to the given sequence
fun void playBell(int sequence)
{
    while (true) {
        // if sequence is 1, just advance time, do not play
        if (sequence == 1 || sequence == 2) {
            globals.quarter => now;
        } else if (sequence == 3) {
            0.5::globals.quarter => now;
            playShaker(bell, 1.0, 0.5);
        } else {
            playShaker(bell, 1.0, 1.0);
        }
    }
}

// play the mug sound according to the given sequence
fun void playMug(int sequence)
{
    while (true) {
        if (sequence == 1 || sequence == 2) {
            playShaker(mug, 1.0, 0.25);
            repeat(3) playShaker(mug, 0.5, 0.25);
            playShaker(mug, 0.7, 0.25);
            repeat(3) playShaker(mug, 0.5, 0.25);
        } else {
            0.75::globals.quarter => now;
            playShaker(mug, 1.0, 0.25);
        }
    }
}

// spork the functions that play the bell and the mug
spork ~ playBell(sequence);
spork ~ playMug(sequence);

// Main loop that just advances the time
while (true) {
    globals.quarter => now;
}