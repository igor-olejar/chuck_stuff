<<< "Assignment 4 - Le Bolotheque" >>>;

/**************************************/
/* Sound Network                      */
/**************************************/
SinOsc bass => dac;
SndBuf kick => dac;
SndBuf hihat1 => Pan2 hihat_pan => dac;
SndBuf hihat2 => hihat_pan;
SndBuf snare1 => Pan2 snare_pan => dac;
SndBuf snare2 => snare_pan;
SndBuf click1 => Pan2 click1_pan => dac;
SndBuf click2 => Pan2 click2_pan => dac;

// pad sound
TriOsc chord_synths[3];
chord_synths[1] => Pan2 synth1_pan => dac;
chord_synths[2] => Pan2 synth2_pan => dac;
-1 => synth1_pan.pan;
1 => synth2_pan.pan;


/**************************************/
/* GLOBALS                            */
/**************************************/
// Scale
[51, 53, 55, 56, 58, 60, 61, 63] @=> int notes[];

// Define a quarter note
0.6::second => dur quarter; 

// Beginning of time
now => time beginning_of_time;

// End of time
30::second + now => time end_of_time;

// Define master gain
0.8 => float master_gain;
0 => float master_silence;
master_gain => dac.gain;

// chord combinations
[[1, 2, 5], [2, 6, 7], [1, 2, 3], [5, 6, 7], [4, 5, 6]] @=> int chord_combo[][];

// sequences
[
[2, -1, -1,  1,      2, -1, -1,  3,    4, -1,  3, -1,     0,  1, -1,  2], // pad
[1,  0,  0,  0,      1,  0,  0,  0,    1,  0,  0,  0,     1,  0,  0,  0] // kick
] @=> int sequence_1[][];


/**************************************/
/* FUNCTIONS                          */
/**************************************/
function void chuckToDac()
{
    for (0 => int i; i < chord_synths.cap(); i++) {
        chord_synths[i] => dac;
        0 => chord_synths[i].gain;
    }
}

function void setChordGain(float gain)
{
    for (0 => int i; i < chord_synths.cap(); i++) {
        gain => chord_synths[i].gain;
    }
}

function void setChordNotes(int indeces[])
{
    for (0 => int i; i < indeces.cap(); i++) {
        Std.mtof(notes[indeces[i]]) => chord_synths[i].freq;
    }
}

function void playSequence(int beat, int seq[][])
{
    // synth
    if (seq[0][beat] > -1) {
        setChordNotes(chord_combo[seq[0][beat]]);
    } else {
        setChordGain(0);
    }
    
    // kick
    if (seq[1][beat]) {
        0 => kick.pos;
    } else {
        kick.samples() => kick.pos;
    }
}

/**************************************/
/* MAIN                               */
/**************************************/
// send all chord synths to dac
chuckToDac();

// load the files
[
"/audio/kick_01.wav",
"/audio/hihat_02.wav",
"/audio/hihat_03.wav",
"/audio/snare_02.wav",
"/audio/snare_03.wav",
"/audio/click_04.wav",
"/audio/click_05.wav"
] @=> string Files[]; // string array holding file locations

me.dir() + Files[0] => kick.read;
me.dir() + Files[1] => hihat1.read;
me.dir() + Files[2] => hihat2.read;
me.dir() + Files[3] => snare1.read;
me.dir() + Files[4] => snare2.read;
me.dir() + Files[5] => click1.read;
me.dir() + Files[6] => click2.read;

// Set the playheads to end of each sample
kick.samples() => kick.pos;
hihat1.samples() => hihat1.pos;
hihat2.samples() => hihat2.pos;
snare1.samples() => snare1.pos;
snare2.samples() => snare2.pos;
click1.samples() => click1.pos;
click2.samples() => click2.pos;

// set the gain of the synth to 0
0 => bass.gain;

0 => int counter; // this variable is used to control the arrangement

//while (now < end_of_time) {
while (true) {
    
    // we're working with 16th notes
    counter % 16 => int beat;
    
    setChordGain(0.07);

    Math.random2f(0.8, 1) => chord_synths[2].width => chord_synths[1].width;
    
    playSequence(beat, sequence_1);
    
    
    0.5::quarter => now;
    
    counter++;
}

<<< "Finished at: ", now/second - beginning_of_time/second, " seconds." >>>;

