// noise.ck

Noise n => ADSR envelope => dac;

0.625::second => dur quarter;

(1::ms, 50::ms, 0.0, 1::ms) => envelope.set;

0.2 => envelope.gain;

fun void playNoise(float timeFrac) 
{
    1 => envelope.keyOn;
    timeFrac::quarter => now;
    1 => envelope.keyOff;
}

while (true) {
    playNoise(0.75);
    playNoise(0.75);
    playNoise(0.5);
}