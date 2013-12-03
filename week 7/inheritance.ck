// A clarinet that understands MIDI noteOn!!
class MyClarinet extends Clarinet
{
    // here we define one new function
    fun float noteOn(int noteNum, float volume) {
        // we set frequency using MIDI note Number
        Std.mtof(noteNum) => this.freq;
        // then call the built-in inherited noteOn
        volume => this.noteOn;
    }
}

// make a new instance of our special clarinet
MyClarinet myclar => dac;

// test our new function
myclar.noteOn(60, 1.0);
1.0 :: second => now;

