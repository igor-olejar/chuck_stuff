SawOsc s[2];

s[0] => ADSR env => BPF filter => Gain oscGain => Gain master => dac;
s[1] => env;

oscGain => Gain oscFeedback => Delay delay => oscGain;

(50::ms, 200::ms, 0.0, 5::ms) => env.set;

.2 => float beattime;

beattime::second => delay.max;
beattime::second => delay.delay;
0.75 => oscFeedback.gain;

0.5 => master.gain;

1000.00 => filter.freq;
0.9 => filter.Q;

220.0 => s[0].freq;
220.5 => s[1].freq;

while (1) {
    Math.random2f(500.0, 2000.0) => filter.freq;
    Math.random2f(0.5, 1.0) => filter.Q;
    env.keyOn();
    0.5::second => now;
    env.keyOff();
    
    1.5::second => now;
}