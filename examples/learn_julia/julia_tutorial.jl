# Crash course in Julia

## Column major indexing:
Random.seed!(1)
C = randn(5,5)
C[:]
reshape(C[:], 5, 5)

## Arrays are passed by reference, no clearing variables
B = zeros(5)
A = B
B[3] = 42
A

# Chinese can be used
朱莉婭 = 5
朱莉婭 * 4

## Function naming convention, timing
function addones!(x::AbstractVector, z::AbstractVector)
	z = x + ones(length(x))
	x = x - ones(length(x))
	return x, z
end

function addones(x::AbstractVector)
	z = similar(y)
	z = x + ones(length(x))
end

x = 3 * ones(5)
y = x
z = zeros(5)

@time x, z = addones!(x, z)
@time z2 = addones(y)

#Try it again

@time x, z = addones!(x,z)
@time z2 = addones(y)

#What happens?

## Types:
f(x::Float64) = x^3

f(4.5)
# now try f(4)

# what happens?

g(x) = x^3
g(4.5)
g(4)
g("Ho ")

## Linear Algebra fun(ctions)!
import LinearAlgebra
Random.seed!(2015)
A = rand(5, 5)
B = A * A'
LinearAlgebra.issym(B)
LinearAlgebra.isposdef(B)
LinearAlgebra.cholesky(B)
W,S,V = LinearAlgebra.svd(B)

## PyPlotting
import PyPlot

PyPlot.plot(S2)
PyPlot.figure()
PyPlot.loglog(S2, linewidth=3, "go--")
PyPlot.gcf()
PyPlot.close("all")

PyPlot.figure()
PyPlot.plot(S2, label = "sv's of A", color="green", linestyle="dashed", marker="o", markersize=12)
PyPlot.plot(S, label = "sv's of B", color="magenta", linestyle="dashed", marker="o", markersize=12)
PyPlot.legend()
PyPlot.gcf()
PyPlot.close("all")

PyPlot.figure()
x = collect(range(0; stop=25, length=100))
PyPlot.plot(x, sin.(x))
PyPlot.plot(y, cos(x))
PyPlot.legend(["sin","cos"],loc="lower left")
PyPlot.gcf()
PyPlot.close("all")

## saving data
import JLD2
import FileIO

FileIO.save("deletedata.jld2", "randA", A, "randB", B)
@JLD2.load("deletedata.jld2")
display(randA)
display(randB)
A = FileIO.load("deletedata.jld2", "randA")
newnameB = FileIO.load("deletedata.jld2", "randB")
rm("deletedata.jld2")