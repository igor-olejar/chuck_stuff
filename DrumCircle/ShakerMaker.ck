// ShakerMaker.ck
// public class that makes shakers

public class ShakerMaker
{
    fun Shakers makeShaker(int instrument, float energy, float objects) {
        Shakers shaker; // create an instance of the Shakers class
        instrument => shaker.preset; // set the preset from the given integer
        energy => shaker.energy; // set the energy of shaking
        objects => shaker.objects; // set the number of shaken objects
        
        return shaker; // return the created shaker object
    }
}