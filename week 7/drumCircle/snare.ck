// snare.ck
// on the fly drumming with global BPM conducting
SndBuf snare => dac;
me.dir(-1)+"/audio/snare_01.wav" => snare.read;
2.0 => snare.gain;
snare.samples() => snare.pos;

// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

while (1)  {
    // update our basic beat each measure
    tempo.quarterNote => dur quarter;

    // play measure of: rest, snare, rest, sna-snare
    quarter => now;
    0 => snare.pos;
    2.0*quarter => now;
    0 => snare.pos;
    quarter/4.0 => now;
    0 => snare.pos;
    3.0*quarter/4.0 => now;
}    
    
