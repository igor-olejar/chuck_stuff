// drums.ck
// Touch of flu

SndBuf kick => dac;
SndBuf click => Pan2 click_pan => dac;
SndBuf snare => ADSR snare_env => dac;

// load the sounds
me.dir(-1) + "/audio/kick_03.wav" => kick.read;
me.dir(-1) + "/audio/click_02.wav" => click.read;
me.dir(-1) + "/audio/snare_02.wav" => snare.read;

// mute the samples
kick.samples() => kick.pos;
click.samples() => click.pos;
snare.samples() => snare.pos;

// get the duration of quarter note from arguments
Std.atof(me.arg(0))::second => dur quarter;

// click pan
0.8 => click_pan.pan;

// click rate
2.5 => click.rate;

// snare envelope settings
(1::ms, 1::ms, 0.0, 1::ms) => snare_env.set;
0.6 => snare_env.gain;

/*************************************************/
/* FUNCTIONS                                     */
/*************************************************/
fun void playClick()
{
    while (true) {
        repeat(4) {
            0 => click.pos;
            0.1::quarter => now;
        }
        1.6::quarter => now;
        
        0 => click.pos;
        2.0::quarter => now;
        
    }
}

fun void playSnare()
{
    while (true) {
        0.5::quarter => now;
        
        repeat(2) {
            triggerSnare();
        }
        
        0.7::quarter => now;
        
        triggerSnare();
        
        0.65::quarter => now;
    }
}

fun void triggerSnare()
{
    0 => snare.pos;
    1 => snare_env.keyOn;
    0.05::quarter => now;
    1 => snare_env.keyOff;
}


/*************************************************/
/* MAIN                                          */
/*************************************************/
spork ~ playClick();
spork ~ playSnare();

while(true){
    0 => kick.pos;
    4::quarter => now;
}
