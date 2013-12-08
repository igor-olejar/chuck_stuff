// initialize.ck
// Hippie Attack

// our conductor/beat-timer class
Machine.add(me.dir() + "/BPM.ck");

// class that contains the notes array as a static variable
Machine.add(me.dir() + "/Notes.ck");

// add classes that create Shakers and Drums
Machine.add(me.dir() + "/ShakerMaker.ck");
Machine.add(me.dir() + "/DrumMaker.ck");

// class that sets all the values up
Machine.add(me.dir() + "/Setup.ck");

// our score
Machine.add(me.dir() + "/score.ck");


