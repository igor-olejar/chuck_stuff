// noise.ck

// global variables
Setup globals;

// get the sequence number from arguments
Std.atoi(me.arg(0)) => int sequence;

// Sound network
Noise n => ADSR envelope => Pan2 noise_pan => dac;

(1::ms, 50::ms, 0.0, 1::ms) => envelope.set; // set the attack, decay, sustain and release of the ADSR envelope

0.3 => noise_pan.pan; // set the gain, just before dac
0.1 => noise_pan.gain; // set the pan

// function that plays the burst of noise
fun void playNoise(float timeFrac) 
{
    1 => envelope.keyOn;
    timeFrac::globals.quarter => now;
    1 => envelope.keyOff;
}

// Main loop
while (true) {
    if (sequence == 1 || sequence == 2) {
        globals.quarter => now;
    } else if (sequence ==3 ) {
        playNoise(0.75);
        playNoise(0.75);
        playNoise(0.5);
    } else {
        Math.random2f(0.1,0.5) => n.gain;
        playNoise(0.25);
        repeat(3) playNoise(0.25);
        playNoise(0.25);
        repeat(3) playNoise(0.25);
    }
}