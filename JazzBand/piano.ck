// piano.ck
// Touch of flu

Wurley piano => PRCRev reverb => dac;

// get the duration of quarter note from arguments
Std.atof(me.arg(0))::second => dur quarter;

// get the sequence number from arguments
Std.atoi(me.arg(1)) => int sequence;

0.6 => reverb.mix;
1.0 => reverb.gain;

// array of midi notes
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];  // total 8

// pp = play piano
fun void pp(int note_index, dur duration, float velocity)
{
    Std.mtof(notes[note_index]) => piano.freq;
    velocity => piano.noteOn;
    duration => now;
    1.0 => piano.noteOff;
}



while(true){
    
    if (sequence == 1) {
        pp(0, 3::quarter, 0.9);
        pp(2, 1::quarter, 0.9);
        pp(5, 3::quarter, 0.9);
        pp(3, 1::quarter, 0.9);
        
        pp(0, 3::quarter, 0.9);
        pp(2, 1::quarter, 0.9);
        pp(5, 3::quarter, 0.9);
        pp(3, 1::quarter, 0.9);
        
        pp(4, 3::quarter, 0.9);
        pp(2, 1::quarter, 0.9);
        pp(6, 3::quarter, 0.9);
        pp(7, 1::quarter, 0.9);
        
        pp(0, 3::quarter, 0.9);
        pp(2, 1::quarter, 0.9);
        pp(5, 3::quarter, 0.9);
        pp(3, 1::quarter, 0.9);
    } else if (sequence == 2) {
        Math.random2(0, 7) => int note_index;
        pp(note_index, 0.25::quarter, Math.random2f(0.4, 0.9));
    } else {
        pp(0, 8::quarter, 0.9);
    }
    
}