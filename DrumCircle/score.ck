// score.ck
Setup globals;
globals.setupAll();

/*Machine.add(me.dir() + "/noise.ck") => int noiseID;
Machine.add(me.dir() + "/shakers.ck") => int shakerID;
Machine.add(me.dir() + "/samples.ck") => int samplesID;
Machine.add(me.dir() + "/moog.ck") => int moogID;
*/

/*** SEQUENCE 1 ***/
// start with shakers and send sequence number 1
Machine.add(me.dir() + "/shakers.ck:" + 1) => int shakerID;

repeat(4) globals.quarter => now;

Machine.remove(shakerID);

