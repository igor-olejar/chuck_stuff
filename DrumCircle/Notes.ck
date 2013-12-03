// Notes.ck
// class that holds composition MIDI notes in a static array
public class Notes
{
    int notes[];
    
    fun void init()
    {
        [48, 50, 52, 53, 55, 57, 59, 60] @=> notes;
    }
}
