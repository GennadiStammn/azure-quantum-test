namespace standalone {

    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    
    operation SampleQuantumRandomNumberGenerator() : Result {
        use q = Qubit();   // Allocate a qubit.
        H(q);              // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
        return M(q);       // Measure the qubit value.
    }

    // @EntryPoint()
    operation SayHello() : Result {
        Message("Hello quantum world!");
        return SampleQuantumRandomNumberGenerator();
    }

    operation SetQubitState(desired : Result, q1 : Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

//    @EntryPoint()
    operation TestBellState(count : Int, initial : Result) : (Int, Int, Int) {
        mutable numOnes = 0;
        mutable agree = 0;
        use (q0, q1) = (Qubit(), Qubit()) {
            for test in 1..count {
                SetQubitState(initial, q0);
                SetQubitState(Zero, q1);

                H(q0);
                CNOT(q0, q1);
                let res = M(q0);

                if (M(q1) == res) {
                    set agree += 1;
                }

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            
            SetQubitState(Zero, q0);
            SetQubitState(Zero, q1);
        }

        // Return times we saw |0>, times we saw |1>, and times measurements agreed
        Message("Test results (# of 0s, # of 1s, # of agreements)");
        return (count-numOnes, numOnes, agree);
    }

    @EntryPoint()
    operation swap() : (Int, Int, Int, Int) {

        mutable s0 = 0;
        mutable s1 = 0;
        mutable s2 = 0;
        mutable s3 = 0;
        use (q0, q1) = (Qubit(), Qubit()) {
            H(q0);
            H(q1);

            if M(q0) == One {
                set s0 = 1;
            } 
            if M(q1) == One {
                set s1 = 1;
            }

            SWAP(q0, q1);

            if M(q0) == One {
                set s2 = 1;
            } 
            if M(q1) == One {
                set s3 = 1;
            }
        }

        return (s0, s1, s2, s3);
    }
}
