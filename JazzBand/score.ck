// score.ck
// Insert the title of your piece here

// Add your composition files when you want them to come in

/*Machine.add(me.dir() + "/drums.ck") => int drumID;

10::second => now;

Machine.add(me.dir() + "/bass.ck") => int bassID;

10::second => now;

Machine.add(me.dir() + "/flute.ck") => int fluteID;
Machine.add(me.dir() + "/piano.ck") => int pianoID;

10::second => now;

Machine.remove(drumID);
Machine.remove(bassID);
Machine.remove(fluteID);
Machine.remove(pianoID);*/

0.625::second => dur quarter; // quarter note

// pad
Machine.add(me.dir() + "/pad.ck") => int padID;
Machine.add(me.dir() + "/drums.ck") => int drumsID;

while (true) quarter => now;