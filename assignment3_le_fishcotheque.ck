<<< "Assignment 3 - Le Fishcotheque" >>>;

// Sound network
Gain master => dac;
TriOsc bass => master;
SndBuf pad => master;
SndBuf kick => master;
SndBuf hihat1 => Pan2 hihat_pan => master;
SndBuf hihat2 => hihat_pan;
SndBuf snare1 => Pan2 snare_pan => master;
SndBuf snare2 => snare_pan;
SndBuf click1 => Pan2 click1_pan => master;
SndBuf click2 => Pan2 slick2_pan => master;

// load the files
me.dir() + "/audio/stereo_fx_03.wav" => pad.read;
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_02.wav" => hihat1.read;
me.dir() + "/audio/hihat_03.wav" => hihat2.read;
me.dir() + "/audio/snare_02.wav" => snare1.read;
me.dir() + "/audio/snare_03.wav" => snare2.read;
me.dir() + "/audio/click_04.wav" => click1.read;
me.dir() + "/audio/click_05.wav" => click2.read;

// Set the playheads to end of each sample
0 => pad.pos; // this sound is reversed
kick.samples() => kick.pos;
hihat1.samples() => hihat1.pos;
hihat2.samples() => hihat2.pos;
snare1.samples() => snare1.pos;
snare2.samples() => snare2.pos;
click1.samples() => click1.pos;
click2.samples() => click2.pos;

// set the gain of the synth to 0
0 => bass.gain;

// D Dorian scale
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Define a quarter note
0.25::second => dur cr; 

// Beginning of time
now => time beginning_of_time;

// End of time
30::second + now => time end_of_time;

// Define master gain
0.6 => master.gain;

// play the pad sound backwards
-1 => pad.rate;

0 => int counter;

while (now < end_of_time) {
    
    // we're working with 16th notes
    counter % 16 => int beat;
    
    // play the kick
    if (beat == 0 || beat == 8) {
        0 => kick.pos;
    }
    
    // divide the length of the pad sample into 16 pieces
    // play each piece from the last one to the first one
    (pad.samples()/16) * (16 - beat) => pad.pos; 
    
    0.5::cr => now;
    
    counter++;
}

