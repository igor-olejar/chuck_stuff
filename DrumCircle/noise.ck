// noise.ck

Setup globals;

// Sound network
Noise n => ADSR envelope => Pan2 noise_pan => dac;

(1::ms, 50::ms, 0.0, 1::ms) => envelope.set;

0.3 => noise_pan.pan;
0.1 => noise_pan.gain;

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