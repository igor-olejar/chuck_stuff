// score.ck
// Touch of flu

// Beginning of time
now => time beginning_of_time;

// End of time
3000::second + now => time end_of_time;

0.625 => float quarter; // quarter note duration

// Scale
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];  // total 8

// pad
Machine.add(me.dir() + "/pad.ck:" + quarter) => int padID;
Machine.add(me.dir() + "/drums.ck:" + quarter) => int drumsID;
Machine.add(me.dir() + "/synth.ck:" + quarter) => int synthID;
Machine.add(me.dir() + "/piano.ck:" + quarter) => int pianoID;

while (now < end_of_time) quarter::second => now;

// kill all the children
Machine.remove(padID);
Machine.remove(drumsID);
Machine.remove(synthID);
Machine.remove(pianoID);

