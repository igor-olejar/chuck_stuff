// Simple Class to show data access
class TestData  {
    // member variables
    1 => int myInt;
    0.0 => float myFrac;
    
    // a simple member function that adds the data
    fun float sum() {
        return myInt + myFrac;
    }
}

// make one of our new testData objects
testData d;

<<< d.myInt, d.myFrac, d.sum() >>>;

// advance time
1:: second => now;

// change the data, just like we would variables
3 => d.myInt;
0.14159 => d.myFrac;

// check to show that happened
<<< d.myInt, d.myFrac, d.sum() >>>;

