SinOsc s[2];
s[0] => dac;
s[1] => dac;

0.7 => float master_gain;

0.25::second => dur quarter;

master_gain => dac.gain;

0 => s[0].gain => s[1].gain;

fun void ADSR(UGen osc, float attack, float decay, float sustain, float release)
{
    // attack grain
    master_gain / attack => float attack_grain;
    
    // set the osc gain to zero, to begin with
    0 => osc.gain;
    
    // do the attack
    for (0 => int i; i <= attack; i++) {
        1::ms => now;
        osc.gain() + attack_grain => osc.gain;
    }
    
    (master_gain - sustain) / decay => float decay_grain;
    for (0 => int i; i <= decay; i++) {
        1::ms => now;
        osc.gain() - decay_grain => osc.gain;
    }
    
    // sustain
    2::quarter/ms - attack - decay - release => float sustain_time;
    
    sustain_time::ms => now;
    
    sustain / release => float release_grain;
    for (0 => int i; i <= release; i++) {
        osc.gain() - release_grain => osc.gain;
        1::ms => now;
    }

}

410 => s[1].freq;
216 => s[0].freq;

ADSR(s[1], 10, 10, 0.4, 220);
ADSR(s[0], 10, 10, 0.4, 220);