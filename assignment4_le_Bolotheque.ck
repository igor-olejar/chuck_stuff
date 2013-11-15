<<< "Assignment 4 - Le Bolotheque" >>>;
<<< "Should be just over 33 seconds, because, you know..." >>>;

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

-0.9 => hihat_pan.pan;
0.4 => snare_pan.pan;

0.8 => click1_pan.pan => click2_pan.pan;


/**************************************/
/* GLOBALS                            */
/**************************************/
// Scale
[51, 53, 55, 56, 58, 60, 61, 63] @=> int notes[];  // total 7

// Define a quarter note
0.6::second => dur quarter; 

// Beginning of time
now => time beginning_of_time;

// End of time
33::second + now => time end_of_time;

// Define master gain
0.3 => float master_gain;
0 => float master_silence;
master_gain => dac.gain;

// chord combinations
[[1, 2, 5], [2, 6, 7], [1, 2, 3], [5, 6, 7], [4, 5, 6]] @=> int chord_combo[][]; // total 5

// sequences
[
[2, -1, -1,  1,      2, -1, -1,  3,    4, -1,  3, -1,     0,  1, -1,  2], // pad
[1,  0,  0,  0,      1,  0,  0,  0,    1,  0,  0,  0,     1,  0,  0,  0], // kick
[0,  0,  1,  0,      0,  0,  0,  1,    0,  0,  1,  0,     0,  1,  0,  0], // snare1
[0,  0,  1,  0,      0,  0,  0,  1,    0,  0,  1,  0,     0,  1,  0,  0], // snare2
[1,  1,  1,  0,      1,  1,  1,  1,    1,  0,  1,  1,     1,  1,  0,  1], // hihat1
[1,  0,  0,  0,      0,  0,  0,  0,    0,  0,  0,  0,     0,  0,  0,  0], // hihat2
[0,  0,  -1, 1,      3,  2, -1,  0,    0,  1,  4,  -1,    5,  4,  1,  0], // bass
[0,  1,  0,  1,      0,  1,  0,  1,    0,  1,  0,  1,     0,  1,  0,  1], // click1
[0,  0,  1,  1,      0,  0,  1,  1,    0,  0,  1,  1,     0,  0,  1,  1] // click2
] @=> int sequence_1[][];

[
[3,  2, -1,  1,      2, -1, -1,  3,    4,  4,  3, -1,     0,  0, -1,  0], // pad
[1,  1,  0,  0,      1,  0,  0,  0,    1,  0,  0,  0,     1,  0,  0,  0], // kick
[0,  1,  0,  0,      0,  1,  0,  1,    0,  1,  0,  0,     0,  1,  1,  0], // snare1
[0,  0,  1,  0,      0,  0,  0,  1,    0,  0,  1,  0,     0,  0,  0,  1], // snare2
[1,  1,  1,  0,      1,  1,  1,  1,    1,  0,  1,  1,     1,  1,  0,  1], // hihat1
[1,  0,  0,  0,      0,  0,  0,  0,    0,  0,  0,  0,     0,  0,  0,  0], // hihat2
[0,  0,  -1,  1,     3,  2, -1,  0,    0,  1,  4,  -1,    5,  4,  1,  0], // bass
[0,  1,  0,  1,      0,  1,  0,  1,    0,  1,  0,  1,     0,  1,  0,  1], // click1
[0,  0,  1,  1,      0,  0,  1,  1,    0,  0,  1,  1,     0,  0,  1,  1] // click2
] @=> int sequence_2[][];

[
[0,  0, 0,  1,      0, 0, 0,  3,    0,  0,  0, 2,     0,  0, 0,  4], // pad
[1,  0,  1,  0,      1,  0,  1,  0,    1,  0,  1,  0,     1,  0,  1,  0], // kick
[1,  1,  0,  0,      1,  1,  0,  1,    1,  1,  0,  0,     1,  1,  0,  0], // snare1
[0,  0,  0,  0,      0,  0,  0,  0,    0,  0,  0,  0,     0,  0,  0,  0], // snare2
[1,  0,  1,  0,      1,  0,  1,  0,    1,  0,  1,  0,     1,  0,  1,  0], // hihat1
[1,  0,  0,  0,      0,  0,  0,  0,    0,  0,  0,  0,     0,  0,  0,  0], // hihat2
[-1,  0,  -1,  0,    -1,  0, -1,  0,   -1,  0,  -1,  0,   -1,  0, -1,  0], // bass
[0,  1,  0,  1,      0,  1,  0,  1,    0,  1,  0,  1,     0,  1,  0,  1], // click1
[0,  0,  1,  1,      0,  0,  1,  1,    0,  0,  1,  1,     0,  0,  1,  1] // click2
] @=> int sequence_3[][];


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
        customEnvelope(10, 10, 0.1, 100);
    } else {
        setChordGain(0);
    }
    
    // kick
    if (seq[1][beat]) {
        0 => kick.pos;
    } else {
        kick.samples() => kick.pos;
    }
    
    // snare1
    if (seq[2][beat]) {
        0 => snare1.pos;
    } else {
        snare1.samples() => snare1.pos;
    }
    
    // snare2
    if (seq[3][beat]) {
        0 => snare2.pos;
    } else {
        snare2.samples() => snare2.pos;
    }
    
    // hihat1
    if (seq[4][beat]) {
        0 => hihat1.pos;
    } else {
        hihat1.samples() => hihat1.pos;
    }
    
    // hihat2
    if (seq[5][beat]) {
        0 => hihat2.pos;
    } else {
        hihat2.samples() => hihat2.pos;
    }
    
    // bass
    if (seq[6][beat] > -1) {
        Std.mtof(notes[seq[6][beat]] - 12) => bass.freq;
        0.6 => bass.gain;
    } else {
        0 => bass.gain;
    }
    
    // click1
    if (seq[7][beat]) {
        0 => click1.pos;
    } else {
        click1.samples() => click1.pos;
    }
    
    // click2
    if (seq[8][beat]) {
        0 => click2.pos;
    } else {
        click2.samples() => click2.pos;
    }
}

fun void customEnvelope(float attack, float decay, float sustain, float release)
{
    // initial gain, for all chord synths
    chord_synths[0].gain() => float initial_gain;
    
    // attack grain
    initial_gain / attack => float attack_grain;
    
    // set the osc gain to zero, to begin with
    setChordGain(0);
    
    // do the attack
    for (0 => int i; i <= attack; i++) {
        1::ms => now;
        setChordGain(chord_synths[0].gain() + attack_grain);
    }
    
    // decay grain
    (initial_gain - sustain) / decay => float decay_grain;
    
    // do the decay
    for (0 => int i; i <= decay; i++) {
        1::ms => now;
        setChordGain(chord_synths[0].gain() + decay_grain);
    }
    
    // sustain time
    0.5::quarter/ms - attack - decay - release => float sustain_time;
    
    sustain_time::ms => now; //play the sound
    
    // release grain
    sustain / release => float release_grain;
    
    // do the release
    for (0 => int i; i <= release; i++) {
        setChordGain(chord_synths[0].gain() + release_grain);
        1::ms => now;
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

// hihat
0.4 => hihat_pan.gain;

0 => int counter; // this variable is used to control the arrangement

while (now < end_of_time) {
    
    // we're working with 16th notes
    counter % 16 => int beat;
    
    // how loud the chords should be
    setChordGain(0.07);
    
    // randomly change the synth width for fun
    Math.random2f(0.8, 1) => chord_synths[2].width => chord_synths[1].width;
    
    // randomly change the rate of snare2
    Math.random2f(0.9, 1.3) => snare2.rate;
    
    // randomly change the rate of clicks
    Math.random2f(-1.0, 1.0) => click1.rate => click2.rate;
    
    if (counter < 16 || (counter >= 32 && counter < 48)) 
        playSequence(beat, sequence_1);
    else if (counter >= 16 && counter < 32)
        playSequence(beat, sequence_2);
    else 
        playSequence(beat, sequence_3);
    
    0.5::quarter => now;
    
    
    counter++;
}

<<< "Finished at: ", now/second - beginning_of_time/second, " seconds." >>>;

