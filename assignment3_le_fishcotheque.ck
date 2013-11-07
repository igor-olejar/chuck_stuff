<<< "Assignment 3 - Le Fishcotheque" >>>;

// Sound network
// Gain master => dac; //not using this because pan doesn't work with master
TriOsc bass => dac;
SndBuf pad_left => HPF pad_filter => dac.left; // using the High Pass Filter to cut out the bottom frequencies (http://chuck.stanford.edu/doc/program/ugen_full.html#HPF)
SndBuf pad_right => HPF pad_filter2 => dac.right;
SndBuf kick => dac;
SndBuf hihat1 => Pan2 hihat_pan => dac;
SndBuf hihat2 => hihat_pan;
SndBuf snare1 => Pan2 snare_pan => dac;
SndBuf snare2 => snare_pan;
SndBuf click1 => Pan2 click1_pan => dac;
SndBuf click2 => Pan2 click2_pan => dac;

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

me.dir() + Files[0] => pad_left.read => pad_right.read;
me.dir() + Files[1] => kick.read;
me.dir() + Files[2] => hihat1.read;
me.dir() + Files[3] => hihat2.read;
me.dir() + Files[4] => snare1.read;
me.dir() + Files[5] => snare2.read;
me.dir() + Files[6] => click1.read;
me.dir() + Files[7] => click2.read;

// Set the playheads to end of each sample
0 => pad_left.pos => pad_right.pos; // this sound is reversed
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
0.7 => float master_gain;
0 => float master_silence;
master_gain => dac.gain;

// play the pad sound backwards
-1 => pad_left.rate;
-1.01 => pad_right.rate;

// set the pad filter frequency and Q value
100.0 => pad_filter.freq => pad_filter2.freq;
1.0 => pad_filter.Q => pad_filter2.Q;


// setting the pan positions
-0.2 => snare_pan.pan;
-0.5 => hihat_pan.pan;
0.5 => click1_pan.pan;
0.95 => click2_pan.pan;

0 => int counter; // this variable is used to control the arrangement

while (now < end_of_time) {
    
    // we're working with 16th notes
    counter % 16 => int beat;
    
    // divide the length of the pad sample into 16 pieces
    // play each piece from the last one to the first one
    (pad_left.samples()/16) * (16 - beat) => pad_left.pos => pad_right.pos; 
    
    // after 4 bars, play some snare
    if (counter > 31 && counter < 92) { // intro
        
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
    } else if (counter >= 92 && counter < 96) { // a little break 
        master_silence => dac.gain;
    } else if (counter > 230) { // fade out
        master_gain / 1.2 => master_gain;
        master_gain => dac.gain;
    } else { // main part of the song
        master_gain => dac.gain;
        
        // Bass sound
        if (counter < 160) {
            0 => bass.gain;
            
            // set the hihats position to hihat.samples()
        } else {
            // bass frequency
            Std.mtof(notes[Math.random2(1, 7)] - 12) => bass.freq;
            if (beat == 0 || beat == 1 || beat == 12 || beat == 13) {
                0.5 => bass.gain; 
            } else {
                0 => bass.gain;
            }
        }
        
        // pad sound
        300.0 => pad_filter.freq => pad_filter2.freq;
        7.0 => pad_filter.Q => pad_filter2.Q;
        0.5 => pad_filter.gain => pad_filter2.gain;
        
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
            
            // click 2
            Math.random2f(0.8, 1.9) => click2.rate;
            0.6 => click2.gain;
            if (beat == 4 || beat == 7 || beat == 11 || beat == 15) {
                0 => click2.pos;
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

<<< "Finished at: ", now/second - beginning_of_time/second, " seconds." >>>;

