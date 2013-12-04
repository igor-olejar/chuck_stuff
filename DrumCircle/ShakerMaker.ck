// ShakerMaker.ck
// public class that makes shakers

public class ShakerMaker
{
    fun Shakers makeShaker(int instrument, float energy, float objects) {
        Shakers shaker;
        instrument => shaker.preset;
        energy => shaker.energy;
        objects => shaker.objects;
        
        return shaker;
    }
}