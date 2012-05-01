module ScrambleTest {
    use Random;

    proc scramble(val: int(64), SCALE: int, seed0: uint(64), seed1: uint(64)){
        var v: uint(64) = val:uint(64);
        v += seed0 + seed1;
        v *= (seed0 | 0x4519840211493211);
        v = (bitreverse(v) >> (64 - SCALE));
        v *= (seed1 | 0x3050852102C843A5);
        v = (bitreverse(v) >> (64 - SCALE));

        return v:int(64);
    }

    proc bitreverse(v: uint(64)): uint(64) {
        var x: uint(64) = v;

        x = (((x & 0xaaaaaaaa) >> 1) | ((x & 0x55555555) << 1));
        x = (((x & 0xcccccccc) >> 2) | ((x & 0x33333333) << 2));
        x = (((x & 0xf0f0f0f0) >> 4) | ((x & 0x0f0f0f0f) << 4));
        x = (((x & 0xff00ff00) >> 8) | ((x & 0x00ff00ff) << 8));

        return((x >> 16) | (x << 16));
    }

    proc main(){
        var rGen = new RandomStream(parSafe=false);
        var SCALE: int = 26;
        var N: int = 2**SCALE;

        var seed0 = (rGen.getNext()*N):uint;
        var seed1 = (rGen.getNext()*N):uint;

        writeln(scramble(2**20, SCALE, seed0, seed1));
    }
}
