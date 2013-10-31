// Playing with some Unit Generators. See http://chuck.stanford.edu/doc/program/ugen.html

<<< "Assignment 2 - Random Ambience" >>>;

// D Dorian scale
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Define a quarter note
0.25::second => dur cr; 

// Beginning of time
now => time beginning_of_time;

// End of time
30::second + now => time end_of_time;

// Define gains
0 => float silence;
0.4 => float master_gain;
master_gain - 0.2 => float snare_gain;
master_gain * 10 => float kick_gain;

// Define drum envelope parameters
1::ms => dur attack;
75::ms => dur decay;
0 => float sustain;
5::ms => dur release;

// Sound network

//Bass sound
SawOsc bass => LPF bass_filter => dac.left; // Using the low-pass filter just to make it a bit nicer
bass_filter => Echo bass_echo => dac.right; // Using the Echo for a bit of chorusing effect
bass_filter.set(200.00, 1.0);

master_gain => bass_filter.gain;

// Kick sound
TriOsc kick => ADSR kick_env => dac;
kick_env.set(attack, decay, sustain, release);
kick_gain => kick_env.gain;

// Snare sound
SqrOsc snare => ADSR snare_env => Pan2 pan => JCRev reverb => dac;
snare_env.set(attack, decay, sustain, release);
0.4 => reverb.mix;
snare_gain => snare.gain;
-0.7 => pan.pan; //snare panning

// Melody 1
SqrOsc melody1 =>Pan2 melody1_pan => dac;

// Melody 2
SawOsc melody2 =>Pan2 melody2_pan => dac;

0 => int i; //counter used for control
while (now < end_of_time)
{
    // Bass frequency
    Math.random2(0, 7) => int bass_index;
    Std.mtof( notes[bass_index] - 24 ) => bass.freq;
    
    //Math.sin(20*(now/second)) => bass_pan.pan;
    
    Std.mtof(notes[0] - 24) => kick.freq;
    Std.mtof(notes[0]) => snare.freq;
    
    if ( (i - (2 * Math.floor(i/2)) ) == 0) { // emulating the modulo operator as it hasn't been "unlocked" yet
        silence => snare.gain;
    } else {
        snare_gain => snare.gain;
    }
    
    //silence => snare.gain;
    //silence => kick.gain;
    // Silence all the melodic synths
    silence => bass.gain;
    
    // Play the melodic sounds after 4 beats
    if (i > 7) {
        master_gain => bass.gain;
    }
    
    kick_env.keyOn();
    snare_env.keyOn();
    2::cr => now;
    kick_env.keyOff();
    snare_env.keyOff();

    i++;
    
    // Fade out
    if (now/second > (end_of_time/second) - 5) {
        master_gain / 1.5 => master_gain;
        setAllLevels(master_gain);
    }
}

<<< "Finished at: ", now/second - beginning_of_time/second, " seconds." >>>;

function void setAllLevels(float new_gain)
{
    new_gain => bass_filter.gain => kick.gain => snare.gain => reverb.gain;
}
