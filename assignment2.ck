// Playing with some Unit Generators. See http://chuck.stanford.edu/doc/program/ugen.html

<<< "Assignment 2" >>>;

// D Dorian scale
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Define a quarter note
0.25::second => dur cr; 

// End of time
30::second + now => time end_of_time;

// Define gains
0 => float silence;
0.3 => float master_gain;
master_gain / 10 => float snare_gain;

// Sound network

//Bass sound
SawOsc bass => LPF bass_filter => dac.left; // Using the low-pass filter just to make it a bit nicer
bass_filter => Echo bass_echo => dac.right; // Using the Echo for a bit of chorusing effect
bass_filter.set(200.00, 1.0);

// Kick sound
TriOsc kick => ADSR drum_env => dac;
drum_env.set(1::ms, 75::ms, 0, 5::ms);

// Snare sound
SqrOsc snare => JCRev reverb => Pan2 pan => drum_env => dac;

0.6 => reverb.mix;

master_gain * 10 => drum_env.gain;
master_gain => bass_filter.gain;
snare_gain => snare.gain;

//snare panning
-0.5 => pan.pan;

0 => int i; //counter
while (now < end_of_time)
{
    // Bass frequency
    Math.random2(0, 7) => int bass_index;
    Std.mtof( notes[bass_index] - 24 ) => bass.freq;
    
    //Math.sin(20*(now/second)) => bass_pan.pan;
    
    Std.mtof(notes[0] - 24) => kick.freq;
    Std.mtof(notes[0]) => snare.freq;
    
    if (i%2 == 0) {
        silence => snare.gain;
    } else {
        snare_gain => snare.gain;
    }
    
    
    drum_env.keyOn();
    2::cr => now;
    drum_env.keyOff();
    
    i++;
}
