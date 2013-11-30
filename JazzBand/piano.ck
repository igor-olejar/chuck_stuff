// piano.ck
// Touch of flu

Wurley piano => PRCRev reverb => dac;

0.625::second => dur quarter;

0.6 => reverb.mix;
1.0 => reverb.gain;

// array of midi notes
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];  // total 8

Std.mtof(notes[7]) => piano.freq;

while(true){
    0.9 => piano.noteOn;
    quarter => now;
    1.0 => piano.noteOff;
    3::quarter => now;
}