s = Array{Float64}(2)
Mads.rosenbrock_gradient!(rand(2), s)
s = Array{Float64}(2,2)
Mads.rosenbrock_hessian!(rand(2),s)
f = Mads.makerosenbrock(2)
f([1,1]);
f = Mads.makerosenbrock_gradient(2)
f([1,1]);
f = Mads.makepowell(8)
f([1,1,1,1,1,1,1,1]);
f = Mads.makepowell_gradient(8)
f([1,1,1,1,1,1,1,1]);
f = Mads.makesphere(2)
f([1,1]);
f = Mads.makesphere_gradient(2)
f([1,1]);
f = Mads.makedixonprice(2)
f([1,1]);
f = Mads.makedixonprice_gradient(2)
f([1,1]);
f = Mads.makesumsquares(2)
f([1,1]);
f = Mads.makesumsquares_gradient(2)
f([1,1]);
f = Mads.makerotatedhyperellipsoid(2)
f([1,1]);
f = Mads.makerotatedhyperellipsoid_gradient(2)
f([1,1]);