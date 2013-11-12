/*SndBuf click => dac;

me.dir() + "/audio/stereo_fx_01.wav" => click.read;
click.samples() => click.pos;

fun void granularize(int steps)
{
    click.samples()/steps => int grain;
    
    Math.random2(0, click.samples()-grain) => click.pos;
    
    grain::samp => now;
}

// MAIN
while (true)
{
    granularize(20);
}
*/

/*
SndBuf click => dac;
SndBuf kick => dac;
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/snare_03.wav" => click.read;

kick.samples() => kick.pos;
click.samples() => click.pos;
[1,0,0,0,1,0,0,0] @=> int kick_p_1[];
[0,0,1,0,0,0,1,0] @=> int kick_p_2[];

fun void section(int kickArray[], float beattime)
{
    for (0 => int i; i<kickArray.cap(); i++) {
        if (kickArray[i] == 1) {
            0 => kick.pos;
        }
        
        beattime::second => now;
    }
}

while (true)
{
    section(kick_p_2, .2);
}
*/

/*
SndBuf snare => dac;
me.dir() + "/audio/snare_01.wav" => snare.read;
snare.samples() => snare.pos;

fun int drumRoll(int index)
{
    <<< index >>>;
    if (index >= 1) {
        0 => snare.pos;
        index::ms => now;
        return drumRoll(index - 1);
    } else if (index == 0) {
        return 0;
    }
}

drumRoll(50);
*/

TriOsc chord[3]; 
Gain master => dac;
for(0 => int i; i<chord.cap(); i++)
{
    chord[i] => master;
    1.0/chord.cap() => chord[i].gain;
}


fun void playChord(int root, string quality, float length)
{
    Std.mtof(root) => chord[0].freq;
    
    if (quality == "major") {
        Std.mtof(root+4) => chord[1].freq;
    } else if (quality == "minor") {
        Std.mtof(root+3) => chord[1].freq;
    } else {
        <<< "blah" >>>;
    }
    
    Std.mtof(root + 7) => chord[2].freq;
    
    length::ms => now;
}

while (true) {
    playChord(Math.random2(60, 72), "minor", 250);
}