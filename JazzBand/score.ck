// score.ck
// Touch of flu

// Beginning of time
now => time beginning_of_time;

// End of time
3000::second + now => time end_of_time;

0.625 => float quarter; // quarter note duration

// Intro on the piano
1 => int pianoSequence;
Machine.add(me.dir() + "/piano.ck:" + quarter + ":" + pianoSequence) => int pianoID;

repeat(16) {
    quarter::second => now;
}

// add the drums and the pad
Machine.add(me.dir() + "/drums.ck:" + quarter) => int drumsID;
Machine.add(me.dir() + "/pad.ck:" + quarter) => int padID;

repeat(8) {
    quarter::second => now;
}

// add the synth
Machine.add(me.dir() + "/synth.ck:" + quarter) => int synthID;

repeat(8) {
    quarter::second => now;
}

// kill the first piano sequence and add the second
Machine.remove(pianoID);
2 => pianoSequence;
Machine.add(me.dir() + "/piano.ck:" + quarter + ":" + pianoSequence) => pianoID;
repeat(8) {
    quarter::second => now;
}

Machine.remove(padID);
Machine.remove(drumsID);
Machine.remove(synthID);

// just the piano
repeat(8) {
    quarter::second => now;
}

// end
Machine.remove(pianoID);
3 => pianoSequence;
Machine.add(me.dir() + "/piano.ck:" + quarter + ":" + pianoSequence) => pianoID;

repeat(8) {
    quarter::second => now;
}

Machine.remove(pianoID);


