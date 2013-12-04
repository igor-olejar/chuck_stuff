// DrumMaker.ck
// public class that makes drum sounds. Suggested by Gordon Milligan

public class DrumMaker
{
    me.dir(-1) + "/audio/" => string drumPath;
    
    fun SndBuf makeDrum(string instrument, float gain) {
        SndBuf drum;
        
        drumPath + instrument => drum.read;
        drum.samples() => drum.pos;
        gain => drum.gain;
        
        return drum;
    }
}