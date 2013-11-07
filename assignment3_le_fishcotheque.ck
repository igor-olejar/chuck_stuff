<<< "Assignment 3 - Le Fishcotheque" >>>;

// use random numbers


// Sound network
Gain master => dac;
TriOsc bass => master;
SndBuf pad =>HPF pad_filter => master; // using the High Pass Filter to cut out the bottom frequencies (http://chuck.stanford.edu/doc/program/ugen_full.html#HPF)
SndBuf kick => master;
SndBuf hihat1 => Pan2 hihat_pan => master;
SndBuf hihat2 => hihat_pan;
SndBuf snare1 => Pan2 snare_pan => master;
SndBuf snare2 => snare_pan;
SndBuf click1 => Pan2 click1_pan => master;
SndBuf click2 => Pan2 slick2_pan => master;

// load the files
[
"/audio/stereo_fx_03.wav",
"/audio/kick_01.wav",
"/audio/hihat_02.wav",
"/audio/hihat_03.wav",
"/audio/snare_02.wav",
"/audio/snare_03.wav",
"/audio/click_04.wav",
"/audio/click_05.wav"
] @=> string Files[]; // string array holding file locations

me.dir() + Files[0] => pad.read;
me.dir() + Files[1] => kick.read;
me.dir() + Files[2] => hihat1.read;
me.dir() + Files[3] => hihat2.read;
me.dir() + Files[4] => snare1.read;
me.dir() + Files[5] => snare2.read;
me.dir() + Files[6] => click1.read;
me.dir() + Files[7] => click2.read;

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

// set the pad filter frequency and Q value
100.0 => pad_filter.freq;
1.0 => pad_filter.Q;

0 => int counter;

while (now < end_of_time) {
    
    // we're working with 16th notes
    counter % 16 => int beat;
    
    <<< counter >>>;
    
    // divide the length of the pad sample into 16 pieces
    // play each piece from the last one to the first one
    (pad.samples()/16) * (16 - beat) => pad.pos; 
    
    // after 4 bars, play some snare
    if (counter > 31 && counter < 96) { // intro
        
        0.4 => hihat1.gain;
        0.3 => click1.gain;
        
        // bass sound
        Std.mtof(notes[1] - 12) => bass.freq;
        
        if (beat == 0 || beat == 1 || beat == 12 || beat == 13) {
            0.3 => bass.gain; 
        } else {
            0 => bass.gain;
        }
        
        // beats
        if (beat == 8 || beat == 16) {
            0 => snare2.pos;
        } else if (beat == 7 || beat == 14) {
            0 => snare1.pos;
        } else if (beat == 2) {
            0 => hihat1.pos;
        } else if (beat == 12 || beat == 13) {
            0 => click1.pos;
        } else if (beat == 0 || beat == 8) {
            0 => kick.pos;
        }
    } else if (counter <= 31) { // just the kick and pad
        if (beat == 0 || beat == 8) {
            0 => kick.pos;
        }
    } else { // main part of the song
        
        // Bass sound
        if (counter < 160) {
            0 => bass.gain;
            
            // set the hihats position to hihat.samples()
        } else {
            // bass frequency
            Std.mtof(notes[Math.random2(1, 7)] - 12) => bass.freq;
            if (beat == 0 || beat == 1 || beat == 12 || beat == 13) {
                0.3 => bass.gain; 
            } else {
                0 => bass.gain;
            }
        }
        
        // pad sound
        300.0 => pad_filter.freq;
        7.0 => pad_filter.Q;
        0.5 => pad_filter.gain;
        
        //beats
        if (beat == 0 || beat == 4 || beat == 8 || beat == 12) {
            0 => kick.pos;
        }
        
        // snare 1
        if (beat == 4 || beat == 12) {
            0 => snare1.pos;
        }
        
        
        if (counter >= 160) {
            // snare 2
            if (beat == 11) {
                0 => snare1.pos;
            }
            
            // click 1
            if (beat == 2 || beat == 6 || beat == 10 || beat == 14) {
                0 => click1.pos;
            }
        }
        
        
        // hihat 1
        0 => hihat1.pos;
        Math.random2f(0.05, 0.15) => hihat1.gain;
        
        // hihat 2
        0.3 => hihat2.gain;
        if (beat == 13) {
            0 => hihat2.pos;
        }
    }
    
    0.5::cr => now;
    
    counter++;
}

