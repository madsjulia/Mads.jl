# getting around

apropos("help") # search documentation for help
@less(max(1,2)) # show the definition of max function when invoked with arguments 1 and 2
whos() # list of global variables and their types
cd("/Users/monty/Julia")
# cd("C:/") # change working directory to C:/ (on Windows)
pwd() # get current working directory
include("file.jl") # execute source file
require("file.jl") # execute source file if it was not executed before
exit(1) # exit with code 1 (exit code 0 by default)
clipboard(collect(1:10)) # copy data to system clipboard
workspace() # clear worskspace - create new Main module (only to be used interactively)

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

# basic types

1::Int64 # 64-bit integer, no overflow warnings, fails on 32 bit Julia, use Int32 assertion instead
1.0::Float64 # 64-bit float, defines NaN, -Inf, Inf
true::Bool # boolean, allows "true" and "false"
'c'::Char # character, allows Unicode
"s"::String # strings, allows Unicode, see also Strings

int64(1.3) # rounds float to integer
int64('a') # character to integer
int64("a") # error no conversion possible
int64(2.0^300) # error - loss of precision
float64(1) # integer to float
bool(-1) # converts to boolean true
bool(0) # converts to boolean false
char(89.7) # cast float to integer to char
string(true) # cast bool to string (works with other types)

convert(Int64, 1.0) # convert float to integer

typeof("abc") # ASCIIString returned which is a String subtype
isa(1, Float64) # false, integer is not float
isa(1.0, Float64) # true

BigInt(10)^1000 # big integer
BigFloat(10)^1000 # big float, see documentation how to change default precision
123//456 # rational numbers using // operator

## Complex literals and types

Any # all objects are of this type
None # subtype of all types, no object can have this type
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
cell(2, 3) # 2x3 array of Any
zeros(5) # vector of Float64 zeros
ones(Int64, 2, 1) # 2x1 array of Int64 ones
trues(3), falses(3) # tuple of vector of trues and of falses
eye(3) # 3x3 Float64 identity matrix
linspace(1, 2, 5) # 5 element equally spaced vector
1:10 # iterable from 1 to 10
1:2:10 # iterable from 1 to 9 with 2 skip
reshape(1:12, 3, 4) # 3x4 array filled with 1:12 values
fill("a", 2, 2) # 2x2 array filled with "a"
repmat(eye(2), 3, 2) # 2x2 identity matrix repeated 3x2 times
x = [1, 2] # two element vector
resize!(x, 5) # resize x in place to hold 5 values (filled with garbage)
[1:10] # convert iterator to a vector, also collect(1:10)
[1] # vector with one element (not a scalar)
[x * y for x in 1:2, y in 1:3] # comprehension generating 2x3 array
Float64[x^2 for x in 1:4] # casting comprehension result to Float64
{i/2 for i = 1:3} # comprehension generating array of type Any
[1 2] # 1x2 matrix (hcat function)
[1 2]' # 2x1 matrix (after transposing)
[1, 2] # vector (vcat function)
[1; 2] # vector (hvcat function)
[1 2 3; 1 2 3] # 2x3 matrix (hvcat function)
[1; 2] == [1 2]' # false, different array dimensions
[(1, 2)] # 1-element vector
collect((1, 2)) # 2-element vector by tuple unpacking
[[1 2] 3] # append to a row vector (hcat)
[[1, 2], 3] # append to a column vector (vcat)

a = [x * y for x in 1:2, y in 1, z in 1:3] # 2x1x3 array of Int64
ndims(a) # number of dimensions in a
eltype(a) # type of elements in a
length(a) # number of elements in a
size(a) # tuple containing dimension sizes of a
vec(a) # cast array to vetor (single dimension)
squeeze(a, 2) # remove 2nd dimension as it has size 1
sum(a, 3) # calculate sums for 3rd dimensions, similarly: mean, std,
# prod, minimum, maximum, any, all
count(x -> x > 0, a) # count number of times a predicate is true, similar: all, any

# Array access:
a = linspace(0, 1) # Float64 vector of length 100
a[1] # get scalar 0.0
a[end] # get scalar 1.0 (last position)
a[1:2:end] # every second element from range
a[repmat([true, false], 50)] # select every second element
a[[1, 3, 6]] # 1st, 3rd and 6th element of a
sub(a, 1:2:100) # select virtual submatrix (the same memory)

# Notice the treatment of trailing singleton dimensions:
a = reshape(1:12, 3, 4)
a[:, 1:2] # 3x2 matrix
a[:, 1] # 3-element vector
a[1, :] # 1x4 matrix

# Array assignment:
x = reshape(1:8, 2, 4)
x[:,2:3] = [1 2] # error; size mismatch
x[:,2:3] = repmat([1 2], 2) # OK
x[:,2:3] = 3 # OK
Arrays are assigned and passed by reference. Therefore copying is provided:
	x = cell(2)
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

# Array types syntax examples:
cell(2)::Array{Any, 1} # vector of Any
[1 2]::Array{Int64, 2} # 2 dimensional array of Int64
[true; false]::Vector{Bool} # vector of Bool
[1 2; 3 4]::Matrix{Int64} # matrix of Int64

# Composite types

# Composite types are mutable and passed by reference. You can define and access composite types:

type Point
	x::Int64
	y::Float64
	meta
end
p = Point(0, 0.0, "Origin")
p.x # access field
p.meta = 2 # change field value
p.x = 1.5 # error, wrong data type
p.z = 1 # error - no such field
names(p) # get names of instance fields
names(Point) # get names of type fields

# Dictionaries
# AbstractDict collections (key-value dictionaries):
x = Dict{Float64, Int64}() # empty dictionary mapping floats to integers
x = (Int64=>Int64)[1=>1, 2=>2] # literal syntax creation, optional type information
y = {"a"=>1, (2,3)=>true} # dictionary with type Dict(Any, Any)
y["a"] # element retrieval
y["b"] # error
y["b"] = 'b' # added element
haskey(y, "b") # check if y contains key "b"
keys(y), values(y) # tuple of iterators returing keys and values in y
delete!(y, "b") # delete key from a collection, see also: pop!
get(y,"c","default") # return y["c"] or "default" if not haskey(y,"c")
# Julia also supports operations on sets and dequeues, priority queues and heaps (please refer to documentation).

# Strings

# String operations:
"Hi " * "there!" # string concatenation
"Ho " ^ 3 # repeat string
string("a= ", 123.3) # create using print function
repr(123.3) # fetch value of show function to a string
occursin("CD", "ABCD") # check if first string contains second
"\"\n\t\$" # C-like escaping in strings, new \$ escape
x = 123
"$x + 3 = $(x+3)" # unescaped $ is used for interpolation
"\$199" # to get a $ symbol you must escape it

# PCRE regular expressions handling:
r = r"A|B" # create new regexp
occursin(r, "CD") # false, no match found
m = match(r, "ACBD") # find first regexp match, see documentation for details
# There is a vast number of string functions — please refer to documentation.

# Programming constructs
The simplest way to create new variable is by assignment:
	x = 1.0 # x is Float64
x = 1 # now x is Int32 on 32 bit machine and Int64 on 64 bit machine
y::Float64 = 1.0 # y must be Float64, not possible in global scope performs assertion on y type when it exists

# Expressions can be compound using ; or begin end block:
x = (a = 1; 2 * a) # after: x = 2; a = 1
y = begin
	b = 3
	3 * b
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
function g(x::Int, y::Int) # type restriction
	return y, x # explicit return of a tuple
end
apply(g, 3, 4) # call with apply
apply(g, 3, 4.0) # error - wrong argument
g(x::Int, y::Bool) = x * y # add multiple dispatch
g(2, true) # second definition is invoked
methods(g) # list all methods defined for g
(x -> x^2)(3) # anonymous function with a call
() -> 0 # anonymous function with no arguments
h(x...) = sum(x)/length(x) - mean(x) # vararg function; x is a tuple
h(1, 2, 3) # result is 0
x = (2, 3) # tuple
f(x) # error
f(x...) # OK - tuple unpacking
s(x; a = 1, b = 1) = x * a / b # function with keyword arguments a and b
s(3, b = 2) # call with keyword argument
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
filter(x -> bits(x)[end] == '0', 1:12) # a fancy way to choose even integers from the range

# As a convention functions with name ending with ! change their arguments in-place. See for example resize! in this document.

# Default function argument beasts:
y = 10
f1(x=y) = x; f1() # 10
f2(x=y,y=1) = x; f2() # 10
f3(y=1,x=y) = x; f3() # 1
f4(;x=y) = x; f4() # 10
f5(;x=y,y=1) = x; f5() # error - y not defined yet :(
f6(;y=1,x=y) = x; f6() # 1

# Variable scoping
# The following constructs introduce new variable scope: function, while, for, try/catch, let, type.
# You can define variables as:
# - global: use variable from global scope;
# - local: define new variable in current scope;
# - const: ensure variable type is constant (global only).

# Special cases:
t # error, variable does not exist
f() = global t = 1
f() # after the call t is defined globally
function f1(n)
	x = 0
	for i = 1:n
		x = i
	end
	x
end
f1(10) # 10; inside loop we use outer local variable
function f2(n)
	x = 0
	for i = 1:n
		local x
		x = i
	end
	x
end
f2(10) # 0; inside loop we use new local variable
function f3(n)
	for i = 1:n
		local x # this local can be omitted; for introduces new scope
		x = i
	end
	x
end
f3(10) # error; x not defined in outer scope
const x = 2
x = 3 # warning, value changed
x = 3.0 # error, wrong type
function fun() # no warning
	const x = 2
	x = true
end
fun() # true, no warning
Global constants speed up execution.
The let rebinds the variable:
		Fs = cell(2)
	i = 1
	while i <= 2
		j = i
		Fs[i] = () -> j
		i += 1
	end
	Fs[1](), Fs[2]() # (2, 2); the same binding for j
	Fs = cell(2)
	i = 1
	while i <= 2
		let j = i
			Fs[i] = () -> j
		end
		i += 1
	end
	Fs[1](), Fs[2]() # (1, 2); new binding for j
	Fs = cell(2)
	i = 1
	for i in 1:2
		j = i
		Fs[i] = () -> j
	end
	Fs[1](), Fs[2]() # (1, 2); for loops and comprehensions rebind variables
end

# Modules

# Modules encapsulate code. Can be reloaded, which is useful to redefine functions and types, as top level functions and types are defined as constants.
module M # module name
export x # what module exposes for the world
x = 1
y = 2 # hidden variable
end
whos(M) # list exported variables
x # not found in global scope
M.y # direct variable access possible
# import all exported variables
# load standard packages this way
using M
#import variable y to global scope (even if not exported)
import M.y

# Operators

# Julia follows standard operators with the following quirks:
true || false # binary or operator (singeltons only), || and && use short-circut evaluation
[1 2] & [2 1] # bitwise and operator
1 < 2 < 3 # chaining conditions is OK (singeltons only)
[1 2] .< [2 1] # for vectorized operators need to add '.' in front
x = [1 2 3]
2x + 2(x+1) # multiplication can be omitted between a literal and a variable or a left parenthesis
y = [1, 2, 3]
x + y # error
x .+ y # 3x3 matrix, dimension broadcasting
x + y' # 1x3 matrix
x * y # array multiplication, 1-element vector (not scalar)
x .* y # elementwise multiplication
x == [1 2 3] # true, object looks the same
x === [1 2 3] # false, objects not identical
z = reshape(1:9, 3, 3)
z + x # error
z .+ x # x broadcasted vertically
z .+ y # y broadcasted horizontally
# explicit broadcast of singelton dimensions
# function + is called for each array element
broadcast(+, [1 2], [1; 2])
# Many typical matrix transformation functions are available (see documentation).

# Essential general usage functions

show([1:100]) # show text representation of an object
eps() # distance from 1.0 to next representable Float64
nextfloat(2.0) # next float representable, similarly provided prevfloat
isequal(NaN, NaN) # true
NaN == NaN # false
isequal(1, 1.0) # false
1 == 1.0 # true
isfinite(Inf) # false, similarly provided: isinf, isnan
fld(-5, 3), mod(-5, 3) # (-2, 1), division towards minus infinity
div(-5, 3), rem(-5, 3) # (-1, -2), division towards zero
findall(x -> mod(x, 2) == 0, 1:8) # find indices for which function returns true
identity([1 2 3]) # identity returned
@info("Info") # print information, similarly warn and error (raises error)
ntuple(3, x->2x) # create tuple by calling x->2x with values 1, 2 and 3
isdefined(Mads, :x) # if variable x is defined (:x is a symbol)
fieldtype(1:2,:len) # get type of the field in composite type (passed as symbol)
1:5 |> exp |> sum # function application chaining
zip(1:5, 1:3) |> collect # convert iterables to iterable tuple and pass it to collect
enumerate("abc") # create iterator of tuples (index, collection element)
isempty("abc") # check if collection is empty
'b' in "abc" # check if element is in a collection
indexin(collect("abc"), collect("abrakadabra")) # [11, 9, 0] ('c' not found), needs arrays
findall((in)("abrakadabra"), "abc") # [1, 2] ('c' was not found)
unique("abrakadabra") # return unique elements
issubset("abc", "abcd") # check if every element in fist collection is in the second
argmax("abrakadabra") # index of maximal element (3 - 'r' in this case)
fargmax("abrakadabra") # tuple: maximal element and its index
filter(x->mod(x,2)==0, 1:10) # retain elements of collection that meet predicate
dump(1:2:5) # show all user-visible structure of an object
sort(rand(10)) # sort 10 uniform random variables

# Reading and writing data

# For I/O details refer documentation. Basic operations:
# - readdlm, readcsv: read from file
# - writedlm, writecsv: write to a file
# Warning! Trailing spaces are not discarded if delim=' ' in file reading.

# Random numbers
# Basic random numbers:
Random.seed!(1) # set random number generator seed to 1
rand() # generate random number from U[0,1)
rand(3, 4) # generate 3x4 matrix of random numbers from U[0,1]
rand(2:5, 10) # generate vector of 10 random integer numbers in range form 2 to 5
randn(10) # generate vector of 10 random numbers from standard normal distribution

# Advanced randomness form Distributions package:
using Distributions # load package
sample(1:10, 10) # single bootstrap sample from set 1-10
b = Beta(0.4, 0.8) # Beta distribution with parameters 0.4 and 0.8
# see documentation for supported distributions
mean(b) # expected value of distribution b
# see documentation for other supported statistics
rand(b, 100) # 100 independent random samples from distribution b

# Data frames

# Julia can handle R-like NA by introducing new scalar and extending Array to DataArray:
using DataFrames # load required package
x = NA # scalar NA value
y = DataArray([1:10]) # create DataArray that can contain NAs
y[1] = NA # assign NA to data array
sum(y) # NA, as it contains NA
sum(dropna(y)) # 54, as NA is removed
# Julia can use R-like data frames:
df = DataFrame(A=1:4,B="a") # create data frame with two columns; scalars are expanded
df[:C] = [true, false] # error, new columns must have the same length
df[:C] = repmat([true, false], 2) # OK, new column added
head(df) # data frame head, similar: tail
df[1:2, ["A", "C"]] # select 2 first rows and A and C columns
df[2] # select 2nd column
names(df) # data frame column names
describe(df) # summary of df contents; not really good
colwise(sum, df[[1,3]]) # calculate sum of column 1 and 3 - not really nice output
df2 = readtable("filename") # read data from disk; warning on handling spaces at eol
writetable("filename", df) # write to disk; see documentation for options for read and write

# Plotting
# There are several plotting packages for Julia: Winston, Gadfly and PyPlot. Here we show how to use on PyPlot as it is natural for Python users:

using PyPlot # load PyPlot, example taken from Matplotlib documentation
x = linspace(0, 1)
y = sin.(4 * pi * x) .* exp(-5 * x)
fill(x, y) # you can access any matplotlib.pyplot function
grid(true)
using Distributions # second example
Random.seed!(1)
x = randn(1000)
# hist conflicts with Julia hist so prepend plt.
n, bins, patches = plt.hist(x, 20, normed = 1, facecolor="y")
points = linspace(bins[1], bins[end])
plot(points, pdf(Normal(), points), "r") # add normal density plot

# Macros

# You can define macros (see documentation for details). Useful standard macros.

# Assertions:
@assert 1 == 2 "ERROR" # 2 macro arguments; error raised
import Test # load Base.Test module
@Test.test 1 == 2 # similar to assert; error
@Test.test_approx_eq 1 1.1 # error
@Test.test_approx_eq_eps 1 1.1 0.2 # no error

# Function vectorization:
t(x::Float64, y::Float64 = 1.0) = x * y
t(1.0, 2.0) # OK
t([1.0 2.0]) # error
@vectorize_1arg Float64 t # vectorize first argument
t([1.0 2.0]) # OK
t([1.0 2.0], 2.0) # error
@vectorize_2arg Float64 t # vectorize two arguments
t([1.0 2.0], 2.0) # OK
t(2.0, [1.0 2.0]) # OK
t([1.0 2.0], [1.0 2.0]) # OK

# Benchmarking:
@time [x for x in 1:10^6] # print time and memory
@timed [x for x in 1:10^6] # return value, time and memory
@elapsed [x for x in 1:10^6] # return time
@allocated [x for x in 1:10^6] # return memory

# Taking it all together example
# Simple bootstraping exercise
using Distributions
using PyPlot
using KernelDensity
Random.seed!(1)
# generate 100 observations from correlated normal variates
n = 100
dist = MvNormal([0.0; 0.0], [1.0 0.5; 0.5 1.0])
r = rand(dist, n)'
# create 100 000 bootstrap replications
# and fetch time and memory used
@time bootcor = Float64[cor(r[sample(1:n, n),:])[1, 2] for i in 1:10^5]
# calculate kernel density estimator
kdeboot = KernelDensity.kde(bootcor)
# plot results
plt.hist(bootcor, 50, normed = 1)
plot(kdeboot.x, kdeboot.density, color = "y", linewidth = 3.0)
axvline(0.5, color = "r", linewidth = 3.0)
savefig("corboot.pdf", format = "pdf") # save results to pdf

# Interactive work
# Define a simple piece of code inside module to be able to change function definition without restarting Julia.
module MCint
f(x) = sin.(x * x)
# vectorize f as x * x does not work on vectors
@vectorize_1arg Float64 f
lo = 0.0
hi = 1.0
n = 10^8
# integrate f on [0, 1] via Monte Carlo simulation
tic()
int_mc = mean(f(rand(n) * (hi - lo) + lo))
toc()
# and using adaptive Gauss-Kronrod method
int_gk = quadgk(f, lo, hi)
# example of string interpolation
println("values: \t$int_mc\t$(int_gk[1])")
println("deviation:\t$(int_mc - int_gk[1])")
println("quadgk err:\t$(int_gk[2])")
end
# We save it to test.jl and load it with include("test.jl").
# Now we notice that we could remove line @vectorize_1arg Float64 f and change definition of
# integrated function to f(x) = sin.(x .* x). We can run include("test.jl").
# You get a warning about module redefinition, but function was
# redefined. Surprisingly — at least on my machine — this version of code is a bit slower.
