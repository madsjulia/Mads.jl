# function polymorphism
polyf(x) = x^3

polyf(3)
polyf(3.1415)
polyf("ho ")

z = rand(4,4)
# call the function on matrix
polyf.(z)

h = repeat(["ho "], 3)
polyf.(h)