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

// hi synth
SawOsc s[2];
s[0] => ADSR env => BPF filter => Gain oscGain => reverb => Pan2 synth_pan => dac;
s[1] => env;
oscGain => Gain oscFeedback => Delay delay => oscGain; // delay line


// Bass (mandolin)
Mandolin bass => drum_comp;
bass.bodySize(0.05);
bass.pluckPos(0.6);
bass.stringDamping(0.01);
bass.stringDetune(0.05);

// reverberation level
0.03 => reverb.mix;

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
0.8 => snare.rate;

// set the parameters that act on the noise generator
(1::ms, 60::ms, 0.0, 5::ms) => noise_env.set;
0.5 => noise_env.gain;

// shape the rhodes sound
3.0 => r[0].lfoSpeed => r[1].lfoSpeed => r[2].lfoSpeed;
0.3 => r[0].lfoDepth => r[1].lfoDepth => r[2].lfoDepth;

// shape the rhodes echoes
quarter => a.max => b.max;
0.5::quarter => a.delay;
0.25::quarter => b.delay;
0.5 => a.mix;
0.35 => b.mix;

// set the synth envelope
(50::ms, 200::ms, 0.0, 5::ms) => env.set;
// delay length
0.25::quarter => delay.max;
0.25::quarter => delay.delay;
0.75 => oscFeedback.gain;

// synth filter
1000.00 => filter.freq;
0.9 => filter.Q;

// synth volume and pan
0.2 => env.gain;

// Shaker setup
11 => shaker.which;
1 => shaker.objects;
0.005 => shaker.decay;
880.0 => shaker.freq;
0.6 => shaker_pan.pan;

// hi hat pan
-0.6 => hihat_pan.pan;

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

fun void playSynth(float synth_freq)
{
    synth_freq - 0.5 => s[0].freq; // bit of detuning by 0.5 Hz
    synth_freq + 0.5 => s[1].freq; // bit of detuning
    // open synth envelope
    env.keyOn();
}

/**************************************/
/* MAIN                               */
/**************************************/
0 => int counter;
0 => int bar;

// Composition

// intro
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

rhodesNotes(1,2,4);
rhodesOn(0.6);
1.3::quarter => now;
rhodesOff();

playKick();
0.1::quarter => now; 

playSnare(snare_quiet);
0.1::quarter => now; 

playSnare(snare_loud);
0.5::quarter => now;

while (bar <= 17) {
    
    counter % 16 => int beat;
    
    // increase bar count when the beat is zero
    if (beat == 0) {
        bar++;
    }
    
    // play the shaker
    if (bar < 17) {
        if (beat % 2 == 0) {
            4.0 => shaker.noteOn;
        } else {
            0.5 => shaker.noteOn;
        }
    }
    
    // play the hihat
    0 => hihat.pos;
    hihat.rate(Math.random2f(0.8, 1.2));
    if (beat == 2 && bar < 9) {
        hihat_pan.gain(0.4);
    } else if (beat != 2 && bar < 9) {
        Math.random2f(0.1, 0.2) => hihat_pan.gain;
    } else {
        hihat.samples() => hihat.pos;
    }
    
    // play the kick
    if (bar < 17) {
        if (beat == 0 || beat == 10) {
            playKick();
        } 
    } else if (bar < 18 && beat == 0) {
        playKick();
    }
    
    // play the snare
    if (bar < 9) {
        if (beat == 4 || beat == 12) {
            playSnare(snare_loud);
        } else if (beat == 3 || beat == 11 || beat == 13 || beat == 15) {
            playSnare(snare_quiet);
        }
    } else if (bar < 17 && bar % 3 != 0) {
        if (beat == 2 || beat == 3 || beat == 8 || beat == 9 || beat == 12 || beat == 13 || beat == 15) {
            playSnare(snare_quiet);
        } else if (beat == 4 || beat == 10 || beat == 14) {
            playSnare(snare_loud);
        }
    } else if (bar < 17) {
        if (beat == 1 || beat == 3 || beat == 8 || beat == 9 || beat == 11 || beat == 13 || beat == 15) {
            playSnare(0.6);
        } else if (beat == 2 || beat == 6 || beat == 12) {
            playSnare(snare_loud);
        }
    }
    
    // rhodes
    if (beat == 0 && (bar == 1 || bar == 5)) {
        rhodesNotes(0,2,3);
        rhodesOn(0.6);
    } else if (beat == 0 && (bar == 2 || bar == 6)) {
        rhodesNotes(0,3,4);
        rhodesOn(0.6);
    } else if (beat == 8 && (bar == 2 || bar  == 6)) {
        rhodesNotes(0,4,6);
        rhodesOn(0.6);
    } else if (beat == 0 && (bar == 3 || bar == 7)) {
        rhodesNotes(1,3,4);
        rhodesOn(0.6);
    } else if (beat == 0 && (bar == 4 || bar == 8)) {
        rhodesNotes(1,2,4);
        rhodesOn(0.6);
    } else if ( bar > 8 && bar < 18 && beat == 0) {
        rhodesNotes(0,2,7);
        rhodesOn(0.6);
    } else if ( bar > 8 && bar < 17 && bar%4 == 0 && beat == 8) {
        rhodesNotes(0,4,5);
        rhodesOn(0.6);
    } else if (bar >= 17 && bar < 18 && beat == 0) {
        rhodesNotes(0,4,5);
        rhodesOn(0.6);
    }
    
    
    // bass
    if (beat == 0 && (bar == 1 || bar == 5)) {
        Std.mtof(notes[2] - 24) => bass.freq;
        0.7 => bass.pluck;
    } else if (beat == 6 && (bar == 1 || bar == 5)) {
        Std.mtof(notes[0] - 24) => bass.freq;
        0.7 => bass.pluck;
    } else if (beat == 12 && (bar == 1 || bar == 5)) {
        Std.mtof(notes[7] - 24) => bass.freq;
        0.7 => bass.pluck;
    } else if (beat == 6 && (bar == 2 || bar == 6)) {
        Std.mtof(notes[3] - 24) => bass.freq;
        0.7 => bass.pluck;
    } else if (beat == 0 && (bar == 4 || bar == 8)) {
        Std.mtof(notes[1] - 24) => bass.freq;
        0.7 => bass.pluck;
    } else if (bar > 8 && bar < 17 && beat%3 == 0) {
        Std.mtof(notes[Math.random2(0,7)]) => bass.freq;
        0.5 => bass.pluck;
    }
    
    // synth
    Math.random2f(500.0, 2000.0) => filter.freq;
    Math.random2f(0.5, 1.0) => filter.Q;
    if (bar > 4 && bar < 9 && beat == 0) {
        Math.sin(counter) => synth_pan.pan;
        playSynth(Std.mtof(notes[Math.random2(0,7)]));
    } else if (bar > 8 && bar < 17) {
        0.1 => env.gain;
        playSynth(Std.mtof(notes[0] - 12));
    }    
    
    0.125::quarter => now; 
    
    // close synth envelope
    env.keyOff();
    
    counter++;
}

