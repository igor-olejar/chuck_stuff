//UseBPM2.ck

// sound chain
SinOsc s => dac;
BPM t2; // Define another BPM called t2

800 => int freq;
while (freq > 400)
{
    freq => s.freq;
    t2.quarterNote => now;
    50 -=> freq;
}


