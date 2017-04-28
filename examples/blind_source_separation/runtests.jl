import Mads
import NMF
import Ipopt
import Base.Test

function reconstruct_rand(R, nk)
    srand(2015)

    s1 = rand(100)
    s2 = rand(100)
    s3 = rand(100)
    S = [s1 s2 s3]

    H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
    X = S * H

    Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=R)

    print("1:\n")
    print(Wipopt)
    print("\n")

    #@Base.Test.test SOME Wipopt TEST HERE
end

function reconstruct_sin(R, nk)
    srand(2015)
    s1 = (sin(0.05:0.05:5)+1)/2
    s2 = (sin(0.3:0.3:30)+1)/2
    s3 = (sin(0.2:0.2:20)+1)/2

    S = [s1 s2 s3]
    H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]

    X = S * H

    Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=R)
    
    print("2:\n")
    print(Wipopt)
    print("\n")
    print(Wipopt * Hipopt)
    print("\n")

    #@Base.Test.test SOME Wipopt TEST HERE
    #@Base.Test.test SOME Wipopt * Hipopt TEST HERE
end

function reconstruct_sin_rand(R, nk)
    srand(2015)
    
    s1 = (sin(0.05:0.05:5)+1)/2
    s2 = (sin(0.3:0.3:30)+1)/2
    s3 = rand(100)
    S = [s1 s2 s3]

    H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
    X = S * H

    Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=1)
    
    print("3:\n")
    print(Wipopt)
    print("\n")
    print(Wipopt * Hipopt)
    print("\n")

    #@Base.Test.test SOME Wipopt TEST HERE
    #@Base.Test.test SOME Wipopt * Hipopt TEST HERE
end

function reconstruct_disturbance(R, nk)
    srand(2015)

    s1 = (sin(0.3:0.3:30)+1)/2
    s2 = rand(100) * 0.5
    s3 = rand(100)
    s3[1:50] = 0
    s3[70:end] = 0
    S = [s1 s2 s3]

    H = [[1,1,1] [0,2,1] [0,2,1] [1,0,2] [2,0,1] [1,2,0] [2,1,0]]
    X = S * H

    Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=1)

    print("4:\n")
    print(Wipopt)
    print("\n")
    print(Wipopt * Hipopt)
    print("\n")

    #@Base.Test.test SOME Wipopt TEST HERE
    #@Base.Test.test SOME Wipopt * Hipopt TEST HERE
end

R = 1
nk = 3

@Base.Test.testset "Blind source seperation" begin
    reconstruct_rand(R, nk)
    #reconstruct_sin(R, nk)
    #reconstruct_sin_rand(R, nk)
    #reconstruct_disturbance(R, nk)
end