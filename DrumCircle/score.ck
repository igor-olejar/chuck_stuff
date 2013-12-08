// score.ck
// scoring the whole 'composition'

Setup globals; // make an instance of the Setup class
globals.setupAll(); // this sets up the tempo (length of the quarter note) and the array of MIDI notes

// define 'beat' for convenience. 1 beat = 4 quarter notes
1 => int beat;

/*** SEQUENCE 1 ***/
// start with shakers and send sequence number 1
1 => int sequence;
Machine.add(me.dir() + "/shakers.ck:" + sequence) => int shakerID;
Machine.add(me.dir() + "/samples.ck:" + sequence) => int samplesID;

repeat(beat) 4::globals.quarter => now;

Machine.remove(shakerID);
Machine.remove(samplesID);

/*** SEQUENCE 2 ***/
2 => sequence;
Machine.add(me.dir() + "/shakers.ck:" + sequence) => shakerID;
Machine.add(me.dir() + "/samples.ck:" + sequence) => samplesID;
Machine.add(me.dir() + "/moog.ck:" + sequence) => int moogID;

repeat(2 * beat) 4::globals.quarter => now;

Machine.remove(shakerID);
Machine.remove(samplesID);
Machine.remove(moogID);

/*** SEQUENCE 3 ***/
3 => sequence;
Machine.add(me.dir() + "/noise.ck:" + sequence) => int noiseID;
Machine.add(me.dir() + "/shakers.ck:" + sequence) => shakerID;
Machine.add(me.dir() + "/samples.ck:" + sequence) => samplesID;
Machine.add(me.dir() + "/moog.ck:" + sequence) => moogID;

repeat (4 * beat) 4::globals.quarter => now;

Machine.remove(noiseID);
Machine.remove(shakerID);
Machine.remove(samplesID);
Machine.remove(moogID);

/*** SEQUENCE 4 ***/
4 => sequence;
Machine.add(me.dir() + "/noise.ck:" + sequence) => noiseID;
Machine.add(me.dir() + "/shakers.ck:" + sequence) => shakerID;
Machine.add(me.dir() + "/samples.ck:" + sequence) => samplesID;
Machine.add(me.dir() + "/moog.ck:" + sequence) => moogID;

repeat (4 * beat) 4::globals.quarter => now;

Machine.remove(noiseID);
Machine.remove(shakerID);
Machine.remove(samplesID);
Machine.remove(moogID);

/*** SEQUENCE 5 ***/
5 => sequence;
Machine.add(me.dir() + "/moog.ck:" + sequence) => moogID;

repeat (beat) 4::globals.quarter => now;

Machine.remove(moogID);

<<< now / second >>>;



