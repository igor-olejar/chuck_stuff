<<< "Assignment 5 - Le Sociotheque" >>>;

/**************************************/
/* Sound Network                      */
/**************************************/
SndBuf kick1 => Dyno drum_comp => dac;
SndBuf kick2 => drum_comp;
SndBuf snare => JCRev reverb => drum_comp;
SndBuf hihat => Pan2 hihat_pan => dac;
Noise noise => ADSR noise_env => reverb;
//hihat_pan => drum_comp;

// shaker
Shakers shaker => Pan2 shaker_pan => dac;

// Rhodes
Rhodey r[3];
r[0] => Echo a => Echo b => reverb; // using 2 echo lines
r[1] => a;
r[2] => a;


0.02 => reverb.mix;

/**************************************/
/* GLOBALS AND SETTINGS               */
/**************************************/
// Scale
[49, 50, 52, 54, 56, 57, 59, 61] @=> int notes[];  // total 8

// Define a quarter note
0.75::second => dur quarter; 

// Beginning of time
now => time beginning_of_time;

// End of time
30::second + now => time end_of_time;

// Define master gain
1.0 => float master_gain;
0 => float master_silence;
master_gain => dac.gain;

// load the files
[
"/audio/kick_03.wav",
"/audio/kick_04.wav",
"/audio/hihat_02.wav",
"/audio/snare_01.wav"
] @=> string Files[]; // string array holding file locations

me.dir() + Files[0] => kick1.read;
me.dir() + Files[1] => kick2.read;
me.dir() + Files[2] => hihat.read;
me.dir() + Files[3] => snare.read;

// Set the playheads to end of each sample
kick1.samples() => kick1.pos;
kick2.samples() => kick2.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;

// compressor settings
drum_comp.compress();
0.6 => drum_comp.thresh;
30::ms => drum_comp.attackTime;
60::ms => drum_comp.releaseTime;
2.0 => drum_comp.gain;

// kick gain
0.3 => kick2.gain;

// snare gains
2.0 => float snare_loud;
0.2 => float snare_quiet;
1.1 => snare.rate;

// set the parameters that act on the noise generator
(1::ms, 60::ms, 0.0, 5::ms) => noise_env.set;
0.8 => noise_env.gain;

// shape the rhodes sound
3.0 => r[0].lfoSpeed => r[1].lfoSpeed => r[2].lfoSpeed;
0.3 => r[0].lfoDepth => r[1].lfoDepth => r[2].lfoDepth;

// shape the rhodes echoes
quarter => a.max => b.max;
0.5::quarter => a.delay;
0.25::quarter => b.delay;
0.5 => a.mix;
0.35 => b.mix;

/**************************************/
/* FUNCTIONS                          */
/**************************************/
fun void playKick()
{
    0 => kick1.pos => kick2.pos;
}

fun void playSnare(float snare_volume)
{
    snare_volume => snare.gain;
    0 => snare.pos;
    
    if (snare_volume > 1.0) {
        noise_env.keyOn();
    }
}

fun void rhodesOn(float velocity)
{
    velocity => r[0].noteOn;
    velocity => r[1].noteOn;
    velocity => r[2].noteOn;
}

fun void rhodesOff()
{
    1.0 => r[0].noteOff;
    1.0 => r[1].noteOff;
    1.0 => r[2].noteOff;
}

fun void rhodesNotes(int note1, int note2, int note3)
{
    Std.mtof(notes[note1]) => r[0].freq;
    Std.mtof(notes[note2]) => r[1].freq;
    Std.mtof(notes[note3]) => r[2].freq;
}

/**************************************/
/* MAIN                               */
/**************************************/
0 => int counter;

11 => shaker.which;
1 => shaker.objects;
0.005 => shaker.decay;
880.0 => shaker.freq;
0.6 => shaker_pan.pan;

-0.6 => hihat_pan.pan;

//while (now < end_of_time) {
// Composition

rhodesNotes(0,2,3);
rhodesOn(0.6);
2::quarter => now;
rhodesOff();

rhodesNotes(0,3,4);
rhodesOn(0.6);
1::quarter => now;
rhodesOff();

rhodesNotes(0,4,6);
rhodesOn(0.6);
1::quarter => now;
rhodesOff();

rhodesNotes(1,3,4);
rhodesOn(0.6);
2::quarter => now;
rhodesOff();

playSnare(snare_loud);
0.5::quarter => now;


while (1) {
    
    counter % 16 => int beat;
    
    <<< beat >>>;
    
    if (beat % 2 == 0) {
        4.0 => shaker.noteOn;
    } else {
        0.5 => shaker.noteOn;
    }
    
    0 => hihat.pos;
    hihat.rate(Math.random2f(0.8, 1.2));
    if (beat == 2) {
        hihat_pan.gain(0.4);
    } else {
        Math.random2f(0.1, 0.2) => hihat_pan.gain;
    }
    
    if (beat == 0 || beat == 10) {
        playKick();
    }
    
    if (beat == 4 || beat == 12) {
        playSnare(snare_loud);
    } else if (beat == 3 || beat == 11 || beat == 13 || beat == 15) {
        playSnare(snare_quiet);
    }
    
    0.125::quarter => now;
    
    counter++;
}

