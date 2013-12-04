// noise.ck

Setup globals;
globals.setupAll();

Noise n => ADSR envelope => dac;

(1::ms, 50::ms, 0.0, 1::ms) => envelope.set;

0.2 => envelope.gain;

fun void playNoise(float timeFrac) 
{
    1 => envelope.keyOn;
    timeFrac::globals.quarter => now;
    1 => envelope.keyOff;
}

while (true) {
    playNoise(0.75);
    playNoise(0.75);
    playNoise(0.5);
}