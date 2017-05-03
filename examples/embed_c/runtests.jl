import Base.Test

# Test Julia's sqrt against C's sqrt in <math.h>
function test_sqrt(d)
    fcsqrt(d) = ccall( (:my_c_sqrt, "libmy.dylib"), Float64, (Float64,), d )
    @Base.Test.test fcsqrt(d) ≈ sqrt(d)
end

# Test an equivalent summation equation
function test_ex1(n, d)
    fcfunc_ex1(n, d) = ccall( (:my_c_func_ex1, "libmy.dylib"), Float64, (Int64, Float64), n, d )

    r = 0
    for i = 1:n
        r += i / d
    end

    @Base.Test.test fcfunc_ex1(n,d) ≈ r
end

# Run the tests
@Base.Test.testset "Calling C" begin
    if isfile("libmy.dylib")
        test_sqrt(2)
        test_ex1(100, 6.4)
    else
        println("C library doesn't exist! Navigate to this directory and `make`")
    end
end

