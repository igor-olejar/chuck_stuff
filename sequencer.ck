Gain master => dac;
SndBuf kick => master;
SndBuf hihat => master;
SndBuf snare => master;

.6 => master.gain;

me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_01.wav" => hihat.read;
me.dir() + "/audio/snare_01.wav" => snare.read;

// set playheads to end
kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;

// initialize counter
0 => int counter;

while(true)
{
    counter % 8 => int beat;
    
    if (beat == 0 || beat == 4) 
    {
        0 => kick.pos;
    }
    
    if (beat == 2 || beat == 6) 
    {
        0 => snare.pos;
        Math.random2f(.6,1.4) => snare.rate;
    }
    
    0 => hihat.pos;
    .2 => hihat.gain;
    Math.random2f(.2,1.8) => hihat.rate; // how fast the sample is played
    
    counter++;
    
    200::ms => now;
}