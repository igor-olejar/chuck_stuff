// Notes.ck
// class that holds composition MIDI notes in a static array
public class Notes
{
    int notes[]; // array to hold our MIDI notes
    
    // function that assigns the array of integers into our 'notes' array
    fun void init()
    {
        [48, 50, 52, 53, 55, 57, 59, 60] @=> notes;
    }
}
