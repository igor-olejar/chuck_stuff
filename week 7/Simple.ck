// Simple example of a sound-making class
class Simple  
{
    // our Simple sound chain
    Impulse imp => ResonZ filt => dac;
    
    // some default settings
    100.0 => filt.Q => filt.gain;
    1000.0 => filt.freq;
    
    // set freq as we would any instrument 
    fun void freq(float freq)
    {
        freq => filt.freq;
    }    
    
    // method to allow setting Q
    fun void setQ(float Q)
    {
        Q => filt.Q => filt.gain;
    }
    
    // method to allow setting gain
    fun void setGain(float gain)
    {
        gain => imp.gain;
    }
    
    // play a note by firing impulse
    fun void noteOn(float volume)
    {
        volume => imp.next;
    }
}

// Make an instance of (declare) one of our Simples
Simple s;

while (1)  {
    // random frequency, Q and gain
   Math.random2f(1100.0,1200.0) => s.freq;
   Math.random2f(1,200) => s.setQ;
   Math.random2f(.2,.8) => s.setGain;
    // play a note and wait a bit
    1 => s.noteOn;
    0.1 :: second => now;
}
