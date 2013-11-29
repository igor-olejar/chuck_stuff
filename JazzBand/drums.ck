// drums.ck
// Insert the title of your piece here

SndBuf kick => dac;
SndBuf click => Pan2 click_pan => dac;

// load the sounds
me.dir(-1) + "/audio/kick_03.wav" => kick.read;
me.dir(-1) + "/audio/click_02.wav" => click.read;

// mute the samples
kick.samples() => kick.pos;
click.samples() => click.pos;

// get the duration of quarter note from arguments
Std.atof(me.arg(0))::second => dur quarter;

// click pan
0.8 => click_pan.pan;

// click rate
2.5 => click.rate;

fun void playClick()
{
    while (true) {
        repeat(4) {
            0 => click.pos;
            0.1::quarter => now;
        }
        1.6::quarter => now;
    }
}

spork ~ playClick();

while(true){
    0 => kick.pos;
    4::quarter => now;
}