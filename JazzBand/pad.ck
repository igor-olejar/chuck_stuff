// pad.ck
// Insert the title of your piece here

0.625::second => dur quarter; // quarter note

// Sound
SndBuf pad => BPF filter => Chorus chorus => NRev reverb => dac;

// load the sound
me.dir(-1) + "/audio/stereo_fx_05.wav" => pad.read;

// mute the pad sound
pad.samples() => pad.pos;

// chorus
0.5 => chorus.mix;
0.25::quarter / second => chorus.modFreq;
0.3 => chorus.modDepth;

// filter
Std.mtof(46 + 48) => filter.freq;
0.2 => filter.Q;

// reverb
0.2 => reverb.mix;


while (true) {
    
    0 => pad.pos;
    
    3.5::quarter => now;
    
    pad.samples() => pad.pos;
    
    0.5::quarter => now;
}
