SndBuf s => dac;

me.dir() + "/audio/snare_02.wav" => s.read;

s.samples() => s.pos;

0.6 => s.gain;

fun void shortenSample(SndBuf sample, int percentage)
{
    sample.samples() * percentage / 100 => int sample_count;
    0 => sample.pos;
    
    for (0 => int i; i <= sample_count; i++) {
        1::samp => now;
    }
    
    sample.samples() => sample.pos;
}

while (true) {
    
    //0 => s.pos;
    
    shortenSample(s, 7);
    
    1::second => now;
}