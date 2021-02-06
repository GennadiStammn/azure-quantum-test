namespace ionq {

    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Canon;
    
    // @EntryPoint()
    operation GenerateRandomBits() : Result[] {
        use qubits = Qubit[4];
        ApplyToEach(H, qubits);
        return MultiM(qubits);
    }

    @EntryPoint()
    operation swap () : (Result, Result, Result, Result) {
        mutable s0 = Zero;
        mutable s1 = Zero;
        mutable s2 = Zero;
        mutable s3 = Zero;

        use (q0, q1) = (Qubit(), Qubit()) {
            H(q0);
            H(q1);

            set s0 = M(q0);
            set s1 = M(q1);

            SWAP(q0, q1);

            set s2 = M(q0);
            set s3 = M(q1);
        }

        return (s0, s1, s2, s3);
    }
}


