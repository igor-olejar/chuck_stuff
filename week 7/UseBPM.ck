// UseBPM.ck
// sound chain
SinOsc s => dac;
BPM t; // Define t Object of Class BPM
t.tempo(300); // set tempo in BPM

400 => int freq;
while (freq < 800)
{
    freq => s.freq;
    t.quarterNote => now;
    50 +=> freq;
}
