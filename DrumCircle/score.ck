// score.ck
Setup globals;
globals.setupAll();

Machine.add(me.dir() + "/noise.ck") => int noiseID;
Machine.add(me.dir() + "/shakers.ck") => int shakerID;
Machine.add(me.dir() + "samples.ck") => int samplesID;

/*Setup globals;
globals.setupAll();

ShakerMaker sm;
//sm.makeShaker(7, 0.9, 20.0) @=> Shakers someShaker => dac; // sleigh bell
sm.makeShaker(15, 0.9, 20.0) @=> Shakers someShaker => dac; // mug

DrumMaker dm;
dm.makeDrum("kick_01.wav", 0.2) @=> SndBuf kick => dac;

0.2 => someShaker.noteOn;
globals.quarter => now;
1.0 => someShaker.noteOff;

0 => kick.pos;
globals.quarter => now;
*/
