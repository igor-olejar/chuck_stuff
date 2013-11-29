// score.ck
// Insert the title of your piece here

// Beginning of time
now => time beginning_of_time;

// End of time
3000::second + now => time end_of_time;

0.625 => float quarter; // quarter note duration

// Scale
[46, 48, 49, 51, 53, 54, 56, 58] @=> int notes[];  // total 8

// pad
Machine.add(me.dir() + "/pad.ck:" + quarter) => int padID;
Machine.add(me.dir() + "/drums.ck") => int drumsID;

while (now < end_of_time) quarter::second => now;

// kill all the children
Machine.remove(padID);
Machine.remove(drumsID);