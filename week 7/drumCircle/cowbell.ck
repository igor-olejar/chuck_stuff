// cow.ck
// on the fly drumming with global BPM conducting
SndBuf cow => dac;
me.dir(-1)+"/audio/cowbell_01.wav" => cow.read;

// make a conductor for our tempo 
// this is set and updated elsewhere
BPM tempo;

while (1)  {
    // update our basic beat each measure
    tempo.eighthNote => dur eighth;
    
    // play measure of eighths
    for (0 => int beat; beat < 8; beat++)  {
        // but only play on the last 8th
        if (beat == 7) {
            0 => cow.pos;
        }
        eighth => now;
    }
}    
    
