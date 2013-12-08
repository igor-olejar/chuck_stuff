// DrumMaker.ck
// public class that makes drum sounds. Suggested by Gordon Milligan

public class DrumMaker
{
    me.dir(-1) + "/audio/" => string drumPath; // path to drum sounds
    
    // Make a drum sound
    fun SndBuf makeDrum(string instrument, float gain) {
        SndBuf drum; // instance of the SndBuf class
        
        drumPath + instrument => drum.read; // read the wav file into 'drum'
        drum.samples() => drum.pos;
        gain => drum.gain;
        
        return drum; // return the drum object
    }
}