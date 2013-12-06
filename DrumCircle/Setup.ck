// Setup.ck
// class that sets everything up and can be called from anywhere

public class Setup
{
    static dur quarter; // the length of the quarter note
    static int midi_notes[]; // here we keep all the midi note values
    //Gain g;
    
    fun void setupAll()
    {
	// make instance of the BPM class
        BPM tempo;

	// make instance of the Notes class
        Notes notes;
        
	// initialize the BPM class and assign its quarterNote to this class's quarter note
        tempo.init();
        tempo.quarterNote => quarter;
        
	// initialize the Notes class and assign the array of notes to this class's array of notes
        notes.init();
        notes.notes @=> midi_notes;
	
	// set the overall gain level
	//g => dac;
	//0.909 => g.gain;
    }
}
