// BPM.ck
// global BPM conductor Class. Modified from the class
public class BPM
{
    // global variables
    dur myDuration[4];
    dur quarterNote, eighthNote, sixteenthNote, thirtysecondNote;
    
    fun void init()  {
        // beat is BPM, example 120 beats per minute
        
        //60.0/(beat) => float SPB; // seconds per beat
        
        // using the actual time in seconds instead of bpm
        
        0.625::second => quarterNote;
        quarterNote*0.5 => eighthNote;
        eighthNote*0.5 => sixteenthNote;
        quarterNote*0.5 => thirtysecondNote;
        
        // store data in array
        [quarterNote, eighthNote, sixteenthNote, thirtysecondNote] @=> myDuration;
    }
}

