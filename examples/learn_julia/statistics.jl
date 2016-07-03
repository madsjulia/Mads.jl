import Distributions
import Gadfly

# create random vector with normal distribution
dist = Distributions.Uniform(1,2)
dist = Distributions.LogNormal(1,4)
dist = Distributions.Levy(3,4)
dist = Distributions.Beta(10,3)
dist = Distributions.Normal(500, 30)
n=rand(dist, 1000)

mean(n)
std(n)
var(n)
skewness(n)
kurtosis(n)
Distributions.moment(n,3)

# plot the histogram using Gadfly
Gadfly.plot(x=n, Gadfly.Geom.histogram(bincount=40))
Gadfly.plot(x=n, Gadfly.Geom.histogram(bincount=40), Gadfly.Scale.x_log10)


