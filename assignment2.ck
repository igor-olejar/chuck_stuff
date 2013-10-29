<<< "Assignment 2" >>>;


// TO DO
// Use panning, Std and Math libraries

// D Dorian scale
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Define a quarter note
0.25::second => dur cr; 

// End of time
30::second + now => time end_of_time;

// Sound network
SinOsc s => dac;

for (0 => int i; i < notes.cap(); i++)
{
    <<< i, notes[i] >>>;
    Std.mtof(notes[i]) => s.freq;
    cr => now;
}