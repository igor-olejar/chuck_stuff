// pad.ck
// Assignment 6 - Robbin' Robyn

// get the duration of quarter note from arguments
Std.atof(me.arg(0))::second => dur quarter;


// Sound
SndBuf pad => BPF filter => Chorus chorus => NRev reverb => dac.left;
chorus => Echo echo => dac.right;

// load the sound
me.dir(-1) + "/audio/stereo_fx_05.wav" => pad.read;

// mute the pad sound
pad.samples() => pad.pos;

// chorus
0.5 => chorus.mix;
0.25::quarter / second => chorus.modFreq;
0.3 => chorus.modDepth;

// filter
Std.mtof((46 + 48) + Math.random2(-20,20)) => filter.freq;
0.2 => filter.Q;

// reverb
0.2 => reverb.mix;

// echo 
quarter => echo.max;
0.5::quarter => echo.delay;
1.0 => echo.mix;


while (true) {
    
    0 => pad.pos;
    
    3.5::quarter => now;
    
    pad.samples() => pad.pos;
    
    0.5::quarter => now;
}
