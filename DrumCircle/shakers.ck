// shakers.ck

Setup globals;

Machine.add(me.dir() + "/ShakerMaker.ck");
ShakerMaker sm;

sm.makeShaker(7, 0.9, 20.0) @=> Shakers bell => Pan2 bell_pan => dac; // sleigh bell
sm.makeShaker(15, 0.9, 20.0) @=> Shakers mug => Pan2 mug_pan => dac; // mug

0.4 => bell_pan.gain => mug_pan.gain;

-0.5 => bell_pan.pan;
0.5 => mug_pan.pan;

fun void playShaker(Shakers instrument, float velocity, float timeFrac)
{
    velocity => instrument.noteOn;
    timeFrac::globals.quarter => now;
    velocity => instrument.noteOff;
}

fun void playBell(int sequence)
{
    while (true) {
        playShaker(bell, 1.0, 1.0);
    }
}

fun void playMug(int sequence)
{
    while (true) {
        0.75::globals.quarter => now;
        playShaker(mug, 1.0, 0.25);
    }
}

spork ~ playBell();
spork ~ playMug();

while (true) {
    globals.quarter => now;
}