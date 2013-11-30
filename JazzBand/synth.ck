// synth.ck
// Touch of flu

SinOsc modulator => TriOsc osc1 => Pan2 pan1 => dac;
modulator => SqrOsc osc2 => Pan2 pan2 => dac;

// get the duration of quarter note from arguments
Std.atof(me.arg(0))::second => dur quarter;

// array of midi notes
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];  // total 8

// modulator frequency
Std.mtof(notes[0] - 36) => modulator.freq;
// modulation index
500 => modulator.gain;

-1.0 => pan1.pan;
1.0 => pan2.pan;
0.3 => pan1.gain;
0.05 => pan2.gain;

while (true) {
    quarter => now;
}