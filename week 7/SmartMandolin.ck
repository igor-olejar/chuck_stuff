// Four Mando "strings", plus some smarts
class MandoPlayer {
    
    // make an arrary of four mandolin strings and connect them up
    Mandolin m[4];
    m[0] => JCRev rev => Gain master => dac;
    m[1] => rev;
    m[2] => rev;
    m[3] => rev;
    0.02 => rev.mix;
    
    // set all four string frequencies in one function
    fun void freqs(float gStr, float aStr, float dStr, float eStr)
    {
        m[0].freq(gStr);
        m[1].freq(aStr);
        m[2].freq(dStr);
        m[3].freq(eStr);
    }
    
    // set all four string notes in one function        
    fun void notes(int gNote, int aNote, int dNote, int eNote)  {
        m[0].freq(Std.mtof(gNote));
        m[1].freq(Std.mtof(aNote));
        m[2].freq(Std.mtof(dNote));
        m[3].freq(Std.mtof(eNote));
    }
    
    // more MandoPlayer functions
    // damp all strings by amount
    // 0.0 = lots of damping, 1.0 = none
    fun void damp(float amount)  { 
        for (0 => int i; i < 4; i++)  {
            amount => m[i].stringDamping;
        }
    }
    
    // a few named chords to get you started, add your own!!
    fun void chord(string which)  {
        if (which == "G") this.notes(55,62,71,79);
        if (which == "D") this.notes(55,64,72,79);
        if (which == "E") this.notes(57,62,69,78);
    }
    
    // roll a chord from lowest note to highest at rate
    fun void roll(string chord, dur rate) {
        this.chord(chord);
        for (0 => int i; i < 4; i++)  {
            1 => m[i].noteOn;
            rate => now;
        }
    }
    
    // archetypical mandolin strumming
    fun void strum(int note, dur howLong)  {
        int whichString;
        if (note < 62) 0 => whichString;
        else if (note < 69) 1 => whichString;
        else if (note < 76) 2 => whichString;
        else 3 => whichString;
        now + howLong => time stop;
        Std.mtof(note) => m[whichString].freq;
        while (now < stop)  {
            Std.rand2f(0.5,1.0) => m[whichString].noteOn;
            Std.rand2f(0.06,0.09) :: second => now;
        }
    }    
}

// let's try all this out!!  Make a MandoPlayer object
MandoPlayer m;

// and declare some data for chording and strumming
["G","D","G","E","E","E","E","G"] @=> string chords[];
[0.4,0.4,0.4,0.1,0.1,0.1,0.1,0.01] @=> float durs[]; 
[79,81,83] @=> int strums[];

// counter to iterate through the arrays
0 => int i;
// roll the basic chords, reading through the arrays
while (i < chords.cap())  {
    m.roll(chords[i],durs[i] :: second);
    i++;
}

// now strum a few notes
0 => i;
while (i < strums.cap())  {
    m.strum(strums[i++], 1.0 :: second);
}

// then end up with a big open G chord
m.damp(1.0);
m.roll("G", 0.02 :: second);
2.0 :: second => now;

// damp it to silence, letting it ring a little
m.damp(0.01);
1.0 :: second => now;
