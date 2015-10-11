# JULIATUTORIAL Crash course in Julia

## Column major indexing:
srand(1)
C = randn(5,5)
C[:]

## Arrays are passed by reference, no clearing variables
B = zeros(5)
A = B
B[3]=47
A

A = 0
whos()
workspace()
whos()

## Function naming convention, timing
function addones!(x::Vector,z::Vector)
	z = x + ones(length(x))
	x = x - ones(length(x))
	return x,z
end

function addones(x::Vector)
	n = length(x)
	z = zeros(n)
	z = x + ones(n)
end

x = 3*ones(5)
y = x
z = zeros(5)

@time x, z = addones!(x,z)
@time z2 = addones(y)

#Try it again

@time x, z = addones!(x,z)
@time z2 = addones(y)

#What happens?

## Types:
f(x::Float64) = x^3

f(4.5)
# now try f(4)

#what happens?

g(x) = x^3
g(4.5)
g(4)
g("Yo")

## Linear Algebra fun(ctions)!
srand(0)
A = rand(5,5)
B = A*A'
@assert issym(B)
@assert isposdef(B)

# what does assert do? how can we quickly look it up?
chol(B)
L = chol(B,:L)
U = chol(B,:U)

W,S,V = svd(B)
(),S2 = svd(A)

## Plotting fun
using PyPlot

plot(S2)
figure()
loglog(S2,linewidth=3,"go--")
close("all")

figure()
plot(S2,label = "sv's of A",color="green", linestyle="dashed", marker="o",markersize=12)
plot(S,label = "sv's of B",color="magenta", linestyle="dashed", marker="o",markersize=12)
legend()

figure()
x=linspace(0,5,100)
plot(sin(x))
plot(cos(x))
legend(["sin","cos"],loc="lower left")

a = 47
title("a title, a = $(a)"), xlabel("the x-axis label"), ylabel ("the y-axislabel")

@show a

figure()
title("A title with latex,\$\\alpha + \\beta\$, a = $(a)")

mypath = pwd()
savefig(mypath * "/deleteme.pdf")
savefig("deletemetoo.eps")

## saving data
using JLD
mypath = pwd()
JLD.save(mypath * "/deletedata.jld","randA",A,"randB",B)
A = JLD.load(mypath * "deletedata.jld","randA")
newnameB = JLD.load("deletedata.jld","randB")
