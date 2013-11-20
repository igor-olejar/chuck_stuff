Rhodey r[3];
r[0] => Echo a => Echo b => dac;
r[1] => a;
r[2] => a;

[49, 50, 52, 54, 56, 57, 59, 61] @=> int notes[];  // total 8

Std.mtof(notes[0]) => r[0].freq;
Std.mtof(notes[2]) => r[1].freq;
Std.mtof(notes[3]) => r[2].freq;

Std.mtof(notes[0]) => r[0].freq;
Std.mtof(notes[3]) => r[1].freq;
Std.mtof(notes[4]) => r[2].freq;

Std.mtof(notes[1]) => r[0].freq;
Std.mtof(notes[3]) => r[1].freq;
Std.mtof(notes[4]) => r[2].freq;

Std.mtof(notes[0]) => r[0].freq;
Std.mtof(notes[6]) => r[1].freq;
Std.mtof(notes[4]) => r[2].freq;


3.0 => r[0].lfoSpeed => r[1].lfoSpeed => r[2].lfoSpeed;
0.3 => r[0].lfoDepth => r[1].lfoDepth => r[2].lfoDepth;
//r.controlChange(128, 10);

1000::ms => a.max => b.max;
0.5::second => a.delay;
0.75::second => b.delay;
0.5 => a.mix;
0.25 => b.mix;

0.6 => r[0].noteOn;
0.6 => r[1].noteOn;
0.6 => r[2].noteOn;

2::second => now;

0.1 => r[0].noteOff;
0.1 => r[1].noteOff;
0.1 => r[2].noteOff;


