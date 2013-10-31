// Playing with some Unit Generators. See http://chuck.stanford.edu/doc/program/ugen.html
// This should start fading out at 25 seconds and go until 30 seconds

<<< "Assignment 2 - Fromagetheque" >>>;

// D Dorian scale
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Define a quarter note
0.25::second => dur cr; 

// Beginning of time
now => time beginning_of_time;

// End of time
30::second + now => time end_of_time;

// when to fade out
end_of_time/second - 5 => float fade_start;

// Define gains
0 => float silence;
0.4 => float master_gain;
master_gain - 0.2 => float snare_gain;
master_gain * 5 => float kick_gain;

// Define drum envelope parameters
1::ms => dur attack;
75::ms => dur decay;
0 => float sustain;
5::ms => dur release;

// Sound network

//Bass sound
SawOsc bass => LPF bass_filter => dac.left; // Using the low-pass filter just to make it a bit nicer
bass_filter => Echo bass_echo => dac.right; // Using the Echo for a bit of chorusing effect
bass_filter.set(200.00, 1.0); // Setting the filter frequency and Q value
silence => bass.gain; // mute the bass to begin with


// Kick sound
TriOsc kick => ADSR kick_env => dac;
kick_env.set(attack, decay, sustain, release);
kick_gain => kick_env.gain; // setting the initial gain on the kick

// Snare sound
SqrOsc snare => ADSR snare_env => Pan2 pan => JCRev reverb => dac;
snare_env.set(attack, decay, sustain, release);
0.4 => reverb.mix;
snare_gain => snare.gain;
-0.7 => pan.pan; //snare panning

// Melody 1
SqrOsc melody1 =>Pan2 melody1_pan => dac;
silence => melody1.gain;
0.5 => melody1_pan.pan;

// Melody 2
SawOsc melody2 =>Pan2 melody2_pan => dac;
silence => melody2.gain;
-0.9 => melody2_pan.pan;

0 => int i; //counter used for control
while (now < end_of_time)
{
    // Bass frequency
    Math.random2(0, 7) => int bass_index; // generate a random integer between 0 and 7
    Std.mtof( notes[bass_index] - 24 ) => bass.freq; // pick a MIDI note and convert it into frequency
    
    // Kick and snare frequencies
    Std.mtof(notes[0] - 24) => kick.freq;
    Std.mtof(notes[0]) => snare.freq;
    
    // Melody 1 frequency
    Math.random2(0, 7) => int melody1_index;
    Std.mtof( notes[melody1_index] ) => melody1.freq;
    
    // Melody 2 frequency
    Math.random2(0, 7) => int melody2_index;
    Std.mtof( notes[melody2_index] + 12) => melody2.freq;
    
    // Play the snare on every 3rd beat
    if ( (i - (4 * Math.floor(i/4))) != 2) { // emulating the modulo operator as it hasn't been "unlocked" yet
        silence => snare.gain;
    } else {
        snare_gain => snare.gain;
    }
    
    // Play the kick on every 1st and 3rd beat
    if ( (i - (4 * Math.floor(i/4))) == 1 || (i - (4 * Math.floor(i/4))) == 3 ) { // emulating the modulo operator as it hasn't been "unlocked" yet
        silence => kick.gain;
    } else {
        kick_gain => kick.gain;
    }
    
    
    // Play the melodic sounds after 8 beats
    if (i > 15 && ( now/second <= fade_start )) {
        master_gain => bass.gain;
        Math.random2f(0.1, master_gain - 0.50) => melody1.gain; // Random gain for melody 1
        Math.random2f(0.1, master_gain - 0.50) => melody2.gain; // Random gain for melody 2
    } else {
        silence => melody1.gain => melody2.gain; // turn the melody off when we reach the fade out
    }
    
    // Break in the beat, just for some variety
    if ( (i > 30 && i < 38) || (i > 65 && i < 73) ) {
        silence => snare.gain => kick.gain;
    }
    
    
    // Play the drum sounds
    kick_env.keyOn();
    snare_env.keyOn();
    //advance time
    cr => now;
    // Mute drum sounds
    kick_env.keyOff();
    snare_env.keyOff();
    
    i++;
    
    // Fade out
    if (now/second > fade_start) {
        master_gain / 1.5 => master_gain; // reduce the master gain
        setAllLevels(master_gain); // set new gain levels for multiple elements using the setAllLevels function
        master_gain * 5 => kick_env.gain; // a hack for the kick gain
    }
}

<<< "Finished at: ", now/second - beginning_of_time/second, " seconds." >>>;

// This function receives a float number that becomes the new gain
function void setAllLevels(float new_gain)
{
    // set the gain of multiple elements
    new_gain => bass.gain => kick.gain => snare.gain => reverb.gain;
}
