Mandolin b => dac;

55 => b.freq;
b.bodySize(0.05);
b.pluckPos(0.6);
b.stringDamping(0.01);
b.stringDetune(0.05);


b.pluck(0.7);
2::second => now;
//1.0 => b.noteOff;