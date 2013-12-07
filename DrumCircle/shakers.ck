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

0.4 => bell_pan.gain => mug_pan.gain;

-0.8 => bell_pan.pan;
0.8 => mug_pan.pan;

// function that simply plays the sound, given the instrument, velocity and time fraction
fun void playShaker(Shakers instrument, float velocity, float timeFrac)
{
    velocity => instrument.noteOn;
    0.3 => bell_pan.gain => mug_pan.gain;
    
    // advance time
    timeFrac::globals.quarter => now;
    
    // turn the sound off
    velocity => instrument.noteOff;
}

fun void playBell(int sequence)
{
    while (true) {
        // if sequence is 1, just advance time, do not play
        if (sequence == 1) {
            globals.quarter => now;
        } else {
            playShaker(bell, 1.0, 1.0);
        }
    }
}

fun void playMug(int sequence)
{
    while (true) {
        if (sequence == 1) {
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

spork ~ playBell(sequence);
spork ~ playMug(sequence);

while (true) {
    globals.quarter => now;
}