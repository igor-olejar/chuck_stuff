// score.ck
// on the fly drumming with global BPM conducting
BPM tempo;
tempo.tempo(120.0);

Machine.add(me.dir()+"/kick.ck") => int kickID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/snare.ck") => int snareID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/hat.ck") => int hatID;
Machine.add(me.dir()+"/cowbell.ck") => int cowID;
8.0 * tempo.quarterNote => now;

Machine.add(me.dir()+"/clap.ck") => int clapID;
8.0 * tempo.quarterNote => now;

<<< "Set tempo to 80BPM" >>>;
80.0 => float newtempo;
tempo.tempo(newtempo);
8.0 * tempo.quarterNote => now;

<<< "Now set tempo to 160BPM" >>>;
160.0 => newtempo;
tempo.tempo(newtempo);
8.0 * tempo.quarterNote => now;

/* if you want to run OTFBPM to change
// tempo as these all run, then comment
// out the lines below   */

<<< "Gradually decrease tempo" >>>;
while (newtempo > 60.0) {
    newtempo - 20 => newtempo;
    tempo.tempo(newtempo);
    <<< "tempo = ", newtempo >>>;
    8.0 * tempo.quarterNote => now;
}

Machine.remove(kickID);
Machine.remove(snareID);
Machine.remove(hatID);
Machine.remove(cowID);
Machine.remove(clapID);

