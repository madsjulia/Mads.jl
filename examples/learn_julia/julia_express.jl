# Welcome to Julia, a modern language for technical computing!

# REPL

# getting help
# ?exp

# getting around
pwd() # get current working directory
@__DIR__
cd(@__DIR__)
pwd() # get current working directory
cd("..")
pwd()
cd(@__DIR__)
include("file.jl") # execute source file

clipboard(collect(1:10)) # copy data to system clipboard

# Sieve of Eratosthenes, docstrings coming in Julia 0.4
function es(n::Int64) # accepts one 64 bit integer argument
	isprime = ones(Bool, n) # n-element vector of true-s
	isprime[1] = false # 1 is not a prime
	for i in 2:round(Int64, sqrt(n)) # loop integers from 2 to sqrt(n), explicit conversion to integer
		if isprime[i] # conditional evaluation
			for j in (i*i):i:n # sequence from i^2 to n with step i
				isprime[j] = false # j is divisible by i
			end
		end
	end
	return filter(x -> isprime[x], 1:n) # filter using anonymous function
end
println(es(100)) # print all primes less or equal than 100
@time es(10^7) # check function execution time and memory usage

# Julia is a strongly typed language
# Julia is a dynamically typed language
# basic types
1::Int64 # 64-bit integer, no overflow warnings, fails on 32 bit Julia, use Int32 assertion instead
1.0::Float64 # 64-bit float, defines NaN, -Inf, Inf
true::Bool # boolean, allows "true" and "false"
'c'::Char # character, allows Unicode
"s"::AbstractString # strings allow for Unicode

Int64(floor(1.3)) # rounds float to integer
Int64('a') # character to integer

Float64(1) # integer to float
Bool(1) # converts to boolean true
Bool(0) # converts to boolean false

string(true) # cast bool to string (works with other types)

convert(Int64, 1.) # convert float to integer
convert(Int64, ceil(1.1))

typeof("abc") # Stringreturned which is a String subtype
isa(1, Float64) # false, integer is not float
isa(1.0, Float64) # true
typeof(1)

BigInt(10)^1000 # big integer
BigFloat(10)^1000 # big float, see documentation how to change default precision
123//456 # rational numbers using // operator
123//456 + 1//2

Any # all objects are of this type
Nothing # type indicating nothing, subtype of Any
nothing # only instance of Nothing

# tuples
() # empty tuple
(1,) # one element tuple
("a", 1) # two element tuple
('a', false)::(Char, Bool) # tuple type assertion
x = (1, 2, 3)
x[1] # 1 (element)
x[1:2] # (1, 2) (tuple)
x[4] # bounds error
x[1] = 1 # error - tuple is not mutable
a, b = x # tuple unpacking a=1, b=2

# arrays
Array{Char}(undef, 2, 3, 4) # 2x3x4 array of Chars
Array{Int64}(undef, 0, 0) # degenerate 0x0 array of Int64
zeros(5) # vector of Float64 zeros
ones(Int64, 2, 1) # 2x1 array of Int64 ones
trues(3), falses(3) # tuple of vector of trues and of falses
range(1; stop=2, length=5) # 5 element equally spaced vector
1:10 # iterable from 1 to 10
1:2:10 # iterable from 1 to 9 with 2 skip

reshape(1:12, 3, 4) # 3x4 array filled with 1:12 values
fill("a", 2, 2) # 2x2 array filled with "a"
repeat(rand(2, 3), 3, 4) # 2x2 matrix repeated 3x2 times
x = [1, 2] # two element vector
resize!(x, 5) # resize x in place to hold 5 values (filled with garbage)
[1:10] # convert iterator to a vector, also collect(1:10)
[1] # vector with one element (not a scalar)
[x * y for x in 1:2, y in 1:3] # comprehension generating 2x3 array
Float64[x^2 for x in 1:4] # casting comprehension result to Float64
[i/2 for i = 1:3] # comprehension generating array of type Any

[1 2] # 1x2 matrix (hcat function)
[1 2]' # 2x1 matrix (after transposing)
permutedims([1 2])
[1, 2] # vector (vcat function)
[1; 2] # vector (hvcat function)
[1 2 3; 1 2 3] # 2x3 matrix (hvcat function)
[1; 2] == [1 2]' # false, different array dimensions
[(1, 2)] # 1-element vector
collect((1, 2)) # 2-element vector by tuple unpacking
[[1 2] 3] # append to a row vector (hcat)
[[1, 2], 3] # append to a column vector (vcat)

a = [x * y for x in 1:2, y in 1:3, z in 1:4] # 2x3x4 array of Int64
ndims(a) # number of dimensions in a
eltype(a) # type of elements in a
length(a) # number of elements in a
size(a) # tuple containing dimension sizes of a
vec(a) # cast array to vetor (single dimension)
sum(a; dims=3) # calculate sums for 3rd dimensions, similarly: mean, std,
count(x->x > 0, a) # count number of times a predicate is true, similar: all, any

# Array access:
a = collect(range(0; stop=1, length=100))# Float64 vector of length 100
a[1] # get scalar 0.0
a[end] # get scalar 1.0 (last position)
a[1:2:end] # every second element from range
a .< 0.1
a[a .< 0.1]
a[repeat([true, false], 50)] # select every second element
a[[1, 33, 63]] # 1st, 3rd and 6th element of a

# Notice the treatment of trailing singleton dimensions:
a = reshape(1:12, 3, 4)
a[:, 1:2] # 3x2 matrix
a[:, 1] # 3-element vector
a[1, :] # 1x4 matrix

# Array assignment:
x = collect(reshape(1:8, 2, 4))
x[:,2:3] .= [1 2]
x[:,2:3] .= repeat([1 2], 2)
x[:,2:3] .= 3

# Arrays are assigned and passed by reference. Therefore copying is provided:
x = Vector{Any}(undef, 2)
x[1] = ones(2)
x[2] = trues(3)
a = x
b = copy(x) # shallow copy
c = deepcopy(x) # deep copy
x[1] = "Bang"
x[2][1] = false
a # identical as x
b # only x[2][1] changed from original x
c # contents to original x

# Composite types

# Unmutable by default:
struct FixedPoint
	x::Int64
	y::Float64
	meta
end
p = FixedPoint(0, 0.0, "Origin")
p.x # access field
p.meta = 2 # error : cannot assign to field
p.x = 3
fieldnames(FixedPoint) # get names of type fields

# Mutable:
mutable struct Point
	x::Int64
	y::Float64
	meta
end
p = Point(0, 0.0, "Origin")
p.x # access field
p.meta = 2 # change field value
p.x = 3
fieldnames(Point) # get names of type fields

# Dictionaries
# AbstractDict collections (key-value dictionaries):
x = Dict{Float64, Int64}() # empty dictionary mapping floats to integers
x = Dict(1=>1, 2=>2) # literal syntax creation

y = Dict("a"=>1, (2,3)=>true) # dictionary with type Dict(Any, Any)
y["a"] # element retrieval
y["b"] = 'b' # added element

haskey(y, "b") # check if y contains key "b"
keys(y), values(y) # tuple of iterators returing keys and values in y
delete!(y, "b") # delete key from a collection, see also: pop!
get(y,"c","default") # return y["c"] or "default" if not haskey(y,"c")

# Strings

# String operations:
"Hi " * "there!" # string concatenation
"Ho " ^ 3 # repeat string
string("a= ", 123.3) # create using print function
repr(123.3) # fetch value of show function to a string
occursin("CD", "ABCD") # check if first string contains second
x = 123
print("\"hi\"\t a $(x)\n") # C-like escaping in strings, new \$ escape
print("$x + 3 = $(x+3)") # unescaped  is used for interpolation
print("\$199\n") # to get a $ symbol you must escape it

# PCRE regular expressions handling:
r = r"A|B" # create new regexp
occursin(r, "CD") # false, no match found
m = match(r, "ACBD") # find first regexp match, see documentation for details
# There is a vast number of string functions — please refer to documentation.

# Programming constructs
# The simplest way to create new variable is by assignment:
x = 1.0 # x is Float64
x = 1 # now x is Int32 on 32 bit machine and Int64 on 64 bit machine

# Expressions can be compound using ; or begin end block:
x = (a = 7; 6 * a) # after: x = 2; a = 1
y = begin
	b = 7
	12 * b
end # after: y = 9; b = 3

# There are standard programming constructs:
if false # if clause requires Bool test
	z = 1
elseif 1==2
	z = 2
else
	a = 3
end # after this a = 3 and z is undefined
1==2 ? "A" : "B" # standard ternary operator
i = 1
while true
	i += 1
	if i > 10
		break
	end
end
for x in 1:10 # x in collection
	if 3 < x < 6
		continue # skip one iteration
	end
	println(x)
end # x is introduced in loop outer scope

# You can define your own functions:
f(x, y = 10) = x + y # new function f with y defaulting to 10
# last result returned
f(3, 2) # simple call, 5 returned
f(3) # 13 returned

# Multiple dispatch
function g(x::Int, y::Int) # type restriction
	return y * x # explicit return of a tuple
end
g(x::Int, y::Bool) = x + y # add multiple dispatch
g(x, y) = x / y

g(2, true)
g(4, 7)
g(1.1, 0.5)
methods(g) # list all methods defined for g

(x -> x^2)(3) # anonymous function with a call
() -> 0 # anonymous function with no arguments

h(x...) = sum(x) / length(x) # vararg function; x is a tuple
h(1, 2, 3) # result is 0
x = (2, 3) # tuple
h(x) # error
h(x...) # OK - tuple unpacking

s1(x; a = 1, b = 1) = x * a / b # function with keyword arguments a and b
s1(3; b = 2) # call with keyword argument

t(; x::Int64 = 2) = x # single keyword argument
t() # 2 returned
t(; x::Bool = true) = x # no multiple dispatch for keyword arguments; function overwritten
t() # true; old function was overwritten

q(f::Function, x) = 2 * f(x) # simple function wrapper
q(x -> 2 * x, 10) # 40 returned
q(10) do x # creation of anonymous function by do construct, useful in IO
	2 * x
end

m = reshape(1:12, 3, 4)
map(x -> x ^ 2, m) # 3x4 array returned with transformed data
filter(x -> bitstring(x)[end] == '0', 1:12) # a fancy way to choose even integers from the range

# As a convention functions with name ending with ! change their arguments in-place. See for example resize! in this document.

# Default function argument beasts:
y = 10
ff1(x=y) = x; ff1() # 10
ff2(x=y,y=1) = x; ff2() # 10
ff3(y=1,x=y) = x; ff3() # 1

ff4(;x=y) = x; ff4() # 10
ff5(;x=y,y=1) = x; ff5() # 10
ff6(;y=1,x=y) = x; ff6() # 1

# Variable scoping
# The following constructs introduce new variable scope: function, while, for, try/catch, let, type.
# You can define variables as:
# - global: use variable from global scope;
# - local: define new variable in current scope;
# - const: ensure variable type is constant (global only).

# Special cases:
ttt # error, variable does not exist
fg() = global ttt = 1
fg() # after the call ttt is defined globally

function fz1(n)
	x = 0
	for i = 1:n
		x = i
	end
	x
end
fz1(10) # 10; inside loop we use outer local variable

function fz2(n)
	x = 0
	for i = 1:n
		local x
		x = i
	end
	x
end
fz2(10) # 0; inside loop we use new local variable

function fz3(n)
	for i = 1:n
		local x # this local can be omitted; for introduces new scope
		x = i
	end
	x
end
fz3(10) # error; x not defined in outer scope

const xxx = 2
xxx = 3 # warning, value changed
xxx = 3.0 # error, wrong type

# Operators

# Julia follows standard operators with the following quirks:
true || false # binary or operator (singeltons only), || and && use short-circut evaluation
[1, 2] .& [2, 1] # bitwise and operator
1 < 2 < 3 # chaining conditions is OK (singeltons only)
[1, 2] .< [2, 1] # for vectorized operators need to add '.' in front
x = [1 2 3]
2x .+ 2(x .+ 1) # multiplication can be omitted between a literal and a variable or a left parenthesis

y = [1, 2, 3]
x .+ y # 3x3 matrix, dimension broadcasting
x + y' # 1x3 matrix
x * y # array multiplication, 1-element vector (not scalar)
x .* y # elementwise multiplication

x == [1 2 3] # true, object looks the same
x === [1 2 3] # false, objects not identical
x === x

z = reshape(1:9, 3, 3)
z + x # error
z .+ x # x broadcasted vertically
z .+ y # y broadcasted horizontally

# explicit broadcast of singelton dimensions
# function + is called for each array element
broadcast(+, [1 2], [1; 2])
# Many typical matrix transformation functions are available (see documentation).

# Essential general usage functions

@show([1:100]) # show text representation of an object
@info("Info") # print information, similarly warn and error (raises an error)
@warn("Aha!")
@error("No!")

eps() # distance from 1.0 to next representable Float64
eps(Float32) # distance from 1.0 to next representable Float32
nextfloat(2.0) # next float representable, similarly provided prevfloat

isequal(NaN, NaN) # true
isnan(NaN)  # true	
NaN == NaN # false

isequal(1, 1.0) # false
1 == 1.0 # true

isfinite(Inf) # false, similarly provided: isinf, isnan

fld(-5, 3), mod(-5, 3) # (-2, 1), division towards minus infinity
div(-5, 3), rem(-5, 3) # (-1, -2), division towards zero

findall(x -> mod(x, 2) == 0, 1:8) # find indices for which function returns true

identity([1 2 3]) # identity returned

ntuple(x->2x, 3) # create tuple by calling x->2x with values 1, 2 and 3

isdefined(Base, :x) # if variable x is defined (:x is a symbol)
isdefined(Base, :sqrt) # if function sqrt is defined (:x is a symbol)
isdefined(Main, :x)

1:5 .|> exp .|> sum # function application chaining

zip(1:5, 1:3) |> collect # convert iterables to iterable tuple and pass it to collect

enumerate("abc") # create iterator of tuples (index, collection element)
for i = enumerate("abc")
	println(i)
end
for (i, c) = enumerate("abc")
	println("$i - $c")
end

isempty("abc") # check if collection is empty
'b' in "abc" # check if element is in a collection
indexin(collect("abc"), collect("abrakadabra")) # [11, 9, 0] ('c' not found), needs arrays
findall((in)("abrakadabra"), "abc") # [1, 2] ('c' was not found)
unique("abrakadabra") # return unique elements
issubset("abc", "abcd") # check if every element in fist collection is in the second
argmax("abrakadabra") # index of maximal element (3 - 'r' in this case)
filter(x->mod(x,2)==0, 1:10) # retain elements of collection that meet predicate
dump(1:2:5) # show all user-visible structure of an object
sort(rand(10)) # sort 10 uniform random variables

# Reading and writing data

# For I/O details, refer documentation. Basic operations:
# - readdlm, readcsv: read from file
# - writedlm, writecsv: write to a file
# Warning! Trailing spaces are not discarded if delim=' ' in file reading.

# Random numbers
# Basic random numbers:
import Random
Random.seed!(1) # set random number generator seed to 1
rand() # generate random number from U[0,1)
rand(3, 4) # generate 3x4 matrix of random numbers from U[0,1]
rand(2:5, 10) # generate vector of 10 random integer numbers in range form 2 to 5
randn(10) # generate vector of 10 random numbers from standard normal distribution

# Advanced randomness from Distributions package:
import Distributions # load package
Distributions.sample(1:10, 10) # single bootstrap sample from set 1-10
b = Distributions.Beta(0.4, 0.8) # Beta distribution with parameters 0.4 and 0.8
# see documentation for supported distributions
import Statistics
Statistics.mean(b) # expected value of distribution b
# see documentation for other supported statistics
rand(b, 100) # 100 independent random samples from distribution b

y = Vector{Union{Int64,Missing}}(undef, 10)
y .= collect(1:10) # create DataArray that can contain NAs
y[1] = missing # assign missing to data array
sum(y) # missing, as it contains missing
.!ismissing.(y)
sum(y[.!ismissing.(y)]) # 54, as missing is removed

y = Vector{Float64}(undef, 10)
y .= collect(1:10) # create DataArray that can contain NAs
y[1] = NaN # assign missing to data array
sum(y) # missing, as it contains missing
.!isnan.(y)
sum(y[.!isnan.(y)]) # 54, as missing is removed

# Data Frames
# Julia can use R-like data frames:
import DataFrames # load required package
df = DataFrames.DataFrame(A=1:4,B="a") # create data frame with two columns; scalars are expanded
df[!, :C] = repeat([true, false], 2) # OK, new column added
first(df) # data frame head
last(df)
df[1:2, ["A", "C"]] # select 2 first rows and A and C columns
df[!, 2] # select 2nd column
names(df) # data frame column names
DataFrames.describe(df) # summary of df contents; not really good

# Plotting
# There are several plotting packages for Julia: Plots, Gadfly and PyPlot

import Gadfly
import Random

Random.seed!(100)
x = 1:10
y = rand(10)

Gadfly.plot(x=x, y=y)
Gadfly.plot(x=x, y=y, Gadfly.Geom.point, Gadfly.Geom.line)
Gadfly.plot(x=x, y=2. .^ y,
	Gadfly.Scale.y_sqrt, Gadfly.Geom.point, Gadfly.Geom.smooth,
	Gadfly.Guide.xlabel("Time"), Gadfly.Guide.ylabel("Response"), Gadfly.Guide.title("Training"))
func_plot(x) = sin.(x) + sqrt.(x)
Gadfly.plot([sin, cos, sqrt, func_plot], 0, 25)

import PyPlot # load PyPlot, example taken from Matplotlib documentation
x = collect(range(0; stop=1, length=100))
y = sin.(4 * pi .* x) .* exp.(-5 .* x)
PyPlot.figure()
PyPlot.plot(x, y)
PyPlot.gcf()

import Mads
Mads.plotseries(y; xaxis=x)
Mads.plotseries(rand(100,10))

import Distributions # second example
Random.seed!(1)
x = randn(1000)
# hist conflicts with Julia hist so prepend plt.
n, bins, patches = PyPlot.plt.hist(x, 20, facecolor="y")
points = collect(range(bins[1]; stop=bins[end], length=100))
PyPlot.plot(points, Distributions.pdf.(Distributions.Normal(), points), "r") # add normal density plot
PyPlot.gcf()

# Macros

# You can define macros (see the Julia documentation for details). Useful standard macros.

# Assertions:
@assert 1 == 2 "ERROR" # 2 macro arguments; error raised

import Test # load Base.Test module
@Test.test 1 == 2 # similar to assert; error
@Test.test 1 ≈ 1.1 # error
@Test.test 1 ≈ 1.1 atol=0.2 # no error

# Function vectorization:
t(x::Float64, y::Float64 = 1.0) = x * y
t(1.0, 2.0) # OK
t([1.0 2.0]) # error
t.([1.0 2.0]) # OK
t([1.0 2.0], 2.0) # error
t.([1.0 2.0], 2.0) # OK
t.(2.0, [1.0 2.0]) # OK
t.([1.0 2.0], [1.0 2.0]) # OK

# Benchmarking:
@time [x for x in 1:10^6] # print time and memory
@timed [x for x in 1:10^6] # return value, time and memory
@elapsed [x for x in 1:10^6] # return time
@allocated [x for x in 1:10^6] # return memory

# More info about defined functions:
@less(max(1,2))
@less(exp(1)) # show the definition of max function when invoked with arguments 1 and 2
methods(max)
methods(exp)
methods(t)

## saving data
import JLD2
import FileIO

A = collect(1:10)
B = rand(10)
FileIO.save("deletedata.jld2", "randA", A, "randB", B)
@JLD2.load("deletedata.jld2")
display(randA)
display(randB)
A = FileIO.load("deletedata.jld2", "randA")
newnameB = FileIO.load("deletedata.jld2", "randB")
rm("deletedata.jld2")