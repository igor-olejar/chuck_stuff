// Title - Assignment 1 - Poor Man's Piano
// A clumsy attempt to synthesize a piano sound and 4-voice polyphony using 8 oscillators

// set the total duration of the piece
28::second + now => time end_of_time;

// set the bpm and find the length of a crotchet, assuming 4/4 signature, 4 crotchets in a bar
95.0 => float bpm;
60.0 / bpm => float crotchet; //float representing the number of seconds that a crotched lasts
crotchet::second => dur cr;

// overall gain
0.2 => float master_gain;

// set the fundamental frequency. We'll stick to the C scale
130.81 => float ff;

// Sound network
// sound 1
SinOsc sine1 => ADSR sine_env1 => JCRev reverb => dac;
SawOsc saw1 => ADSR saw_env1 => reverb => dac;

// sound 2
SinOsc sine2 => ADSR sine_env2 => reverb => dac;
SawOsc saw2 => ADSR saw_env2 => reverb => dac;

// sound 3
SinOsc sine3 => ADSR sine_env3 => reverb => dac;
SawOsc saw3 => ADSR saw_env3 => reverb => dac;

// sound 4
SinOsc sine4 => ADSR sine_env4 => reverb => dac;
SawOsc saw4 => ADSR saw_env4 => reverb => dac;

//set the reverb
master_gain => reverb.gain;
0.05 => reverb.mix;

//set the envelopes
initialiseEnvelopes();

/**
* The actual composition
*/

now / second => float start_time;

playNotes(0.5::cr, ff,1, getFrequency(ff, 7),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );
playNotes(1.5::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 19),1, getFrequency(ff, 24),1 );

playNotes(0.5::cr, getFrequency(ff, 0),1, getFrequency(ff, 7),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );
playNotes(0.5::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 19),1, getFrequency(ff, 24),1 );
playNotes(0.5::cr, getFrequency(ff, 4),1, getFrequency(ff, 9),1, getFrequency(ff, 21),1, getFrequency(ff, 26),1 );

playNotes(0.5::cr, getFrequency(ff, 5),1, getFrequency(ff, 12),1, getFrequency(ff, 24),1, getFrequency(ff, 29),1 );
playNotes(0.5::cr, getFrequency(ff, 4),1, getFrequency(ff, 11),1, getFrequency(ff, 24),1, getFrequency(ff, 28),1 );
playNotes(1.5::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 21),1, getFrequency(ff, 26),1 );

playNotes(0.5::cr, ff,1, getFrequency(ff, 7),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );
playNotes(1.5::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 19),1, getFrequency(ff, 24),1 );

playNotes(0.5::cr, getFrequency(ff, 0),1, getFrequency(ff, 7),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );
playNotes(0.5::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 19),1, getFrequency(ff, 24),1 );
playNotes(0.5::cr, getFrequency(ff, 4),1, getFrequency(ff, 9),1, getFrequency(ff, 21),1, getFrequency(ff, 26),1 );

playNotes(0.5::cr, getFrequency(ff, 5),1, getFrequency(ff, 12),1, getFrequency(ff, 24),1, getFrequency(ff, 29),1 );
playNotes(0.5::cr, getFrequency(ff, 4),1, getFrequency(ff, 11),1, getFrequency(ff, 24),1, getFrequency(ff, 28),1 );
playNotes(2::cr, getFrequency(ff, 2),1, getFrequency(ff, 9),1, getFrequency(ff, 21),1, getFrequency(ff, 26),1 );

playNotes(0.5::cr, getFrequency(ff, 17),1, getFrequency(ff, 7),0, getFrequency(ff, 17),0, getFrequency(ff, 21),0 );

playNotes(0.5::cr, getFrequency(ff, 0),1, getFrequency(ff, 5),1, getFrequency(ff, 12),1, getFrequency(ff, 26),1 );
playNotes(0.5::cr, getFrequency(ff, 31),1, getFrequency(ff, 5),0, getFrequency(ff, 12),0, getFrequency(ff, 14),0 );
playNotes(1.5::cr, getFrequency(ff, 19),1, getFrequency(ff, 21),1, getFrequency(ff, 24),1, getFrequency(ff, 26),1 );

playNotes(1.5::cr, getFrequency(ff, 19),1, getFrequency(ff, 21),1, getFrequency(ff, 24),1, getFrequency(ff, 23),1 );
playNotes(0.5::cr, getFrequency(ff, 33),1, getFrequency(ff, 21),0, getFrequency(ff, 24),0, getFrequency(ff, 23),0 );
playNotes(0.5::cr, getFrequency(ff, 36),1, getFrequency(ff, 21),0, getFrequency(ff, 24),0, getFrequency(ff, 23),0 );

playNotes(1::cr, getFrequency(ff, 24),1, getFrequency(ff, 29),1, getFrequency(ff, 24),0, getFrequency(ff, 38),1 );
playNotes(1::cr, getFrequency(ff, 21),1, getFrequency(ff, 28),1, getFrequency(ff, 24),0, getFrequency(ff, 36),1 );
playNotes(0.5::cr, getFrequency(ff, 17),1, getFrequency(ff, 24),1, getFrequency(ff, 24),0, getFrequency(ff, 31),1 );
playNotes(0.5::cr, getFrequency(ff, 29),1, getFrequency(ff, 24),0, getFrequency(ff, 24),0, getFrequency(ff, 31),0 );

playNotes(1.5::cr, getFrequency(ff, 16),1, getFrequency(ff, 24),1, getFrequency(ff, 24),0, getFrequency(ff, 36),1 );
playNotes(0.5::cr, getFrequency(ff, 16),1, getFrequency(ff, 24),1, getFrequency(ff, 24),0, getFrequency(ff, 31),1 );
playNotes(0.5::cr, getFrequency(ff, 16),0, getFrequency(ff, 24),0, getFrequency(ff, 24),0, getFrequency(ff, 23),1 );
playNotes(0.5::cr, getFrequency(ff, 16),0, getFrequency(ff, 24),0, getFrequency(ff, 24),0, getFrequency(ff, 19),1 );

playNotes(3::cr, getFrequency(ff, 5),1, getFrequency(ff, 12),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );


while (now < end_of_time)
{
    Math.random2(0, 24) => int partial;
    
    
    if ( partial == 1 || partial == 2 || partial == 0 || (partial%4 == 0 && partial%8 !=0) || (partial % 5 == 0 && partial % 10 != 0) || partial % 7 == 0 || partial % 9 == 0 || partial % 11 == 0 ) {
        playNotes(
        1.5::cr, 
        getFrequency(ff, partial), 1, 
        getFrequency(ff, partial + 5), 1, 
        ff, 1, 
        ff, 0
        );
    }
}

now / second => float end_time;
30.0 - (end_time - start_time) => float after_end_of_time;
playNotes(after_end_of_time::second, getFrequency(ff, 0),1, getFrequency(ff, 7),1, getFrequency(ff, 17),1, getFrequency(ff, 21),1 );




/*************************************************************************************/


// functions
function void playNotes(dur duration, float freq1, int mute1, float freq2, int mute2, float freq3, int mute3, float freq4, int mute4)
{
    //set the decay time to be 70% of the note duration
    setDecayTimes(duration);
    
    //set frequencies
    freq1 => sine1.freq => saw1.freq;
    freq2 => sine2.freq => saw2.freq;
    freq3 => sine3.freq => saw3.freq;
    freq4 => sine4.freq => saw4.freq;
    
    // are we muting any sounds?
    if (mute1 == 0) {
        0 => sine1.gain => saw1.gain;
    } else {
        master_gain => sine1.gain => saw1.gain;
    }
    
    if (mute2 == 0) {
        0 => sine2.gain => saw2.gain;
    } else {
        master_gain => sine2.gain => saw2.gain;
    }
    
    if (mute3 == 0) {
        0 => sine3.gain => saw3.gain;
    } else {
        master_gain => sine3.gain => saw3.gain;
    }
    
    if (mute4 == 0) {
        0 => sine4.gain => saw4.gain;
    } else {
        master_gain => sine4.gain => saw4.gain;
    }
    
    keysOn();
    
    duration => now;
    
    keysOff();
}


function float getFrequency (float ff, float partial)
{
    return ff * Math.pow(2.0, partial/12);
}

function void initialiseEnvelopes()
{
    sine_env1.set( 100::ms, 400::ms, 0, 600::ms );
    saw_env1.set( 1::ms, 5::ms, 0, 50::ms );
    
    sine_env2.set( 100::ms, 400::ms, 0, 600::ms );
    saw_env2.set( 1::ms, 2::ms, 0, 50::ms );
    
    sine_env3.set( 100::ms, 400::ms, 0, 600::ms );
    saw_env3.set( 1::ms, 2::ms, 0, 50::ms );
    
    sine_env4.set( 100::ms, 400::ms, 0, 600::ms );
    saw_env4.set( 1::ms, 2::ms, 0, 50::ms );
}

function void setDecayTimes(dur duration)
{
    .7 * duration => sine_env1.decayTime;
    .03 * duration => saw_env1.decayTime;
    .7 * duration => sine_env2.decayTime;
    .03 * duration => saw_env2.decayTime;
    .7 * duration => sine_env3.decayTime;
    .03 * duration => saw_env3.decayTime;
    .7 * duration => sine_env4.decayTime;
    .03 * duration => saw_env4.decayTime;
}

function void keysOn()
{
    sine_env1.keyOn();
    saw_env1.keyOn();
    sine_env2.keyOn();
    saw_env2.keyOn();
    sine_env3.keyOn();
    saw_env3.keyOn();
    sine_env4.keyOn();
    saw_env4.keyOn();
}

function void keysOff()
{
    sine_env1.keyOff();
    saw_env1.keyOff();
    sine_env2.keyOff();
    saw_env2.keyOff();
    sine_env3.keyOff();
    saw_env3.keyOff();
    sine_env4.keyOff();
    saw_env4.keyOff();
}