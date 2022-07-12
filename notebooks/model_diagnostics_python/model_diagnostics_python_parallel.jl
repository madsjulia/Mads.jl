import Distributed
Distributed.addprocs(4)

@Distributed.everywhere import Mads
@Distributed.everywhere import PyCall

@Distributed.everywhere cd(@__DIR__)

@Distributed.everywhere PyCall.py"""
import numpy as np
import os

def my_model(theta, x):
	print(os.getcwd())
	m, c = theta
	y = m * x + c
	np.savetxt('output.out', y, delimiter=',')
	z = np.loadtxt('output.out', delimiter=',', unpack=True)
	return z
"""

PyCall.py"my_model"([1, 2], [1, 2, 3])

@Distributed.everywhere function my_model_pycall(args...)
	@show args
	@show pwd()
	predictions = PyCall.py"my_model"(args..., [1, 2, 3])
	@show predictions
	return predictions
end

my_model_pycall([1, 2])

@Distributed.everywhere md = Mads.createproblem([1.,0.], [1.,2.,3.], my_model_pycall; paramkey=["a", "b"], paramdist=["Uniform(-10, 10)", "Uniform(-10, 10)"], obsweight=[1,1,1], obstime=[1,2,3], obsdist=["Uniform(0, 10)", "Uniform(0, 10)", "Uniform(0, 10)"], problemname="py_model")
@Distributed.everywhere md["Linked directory"] = true

Mads.forward(md)

Mads.calibrate(md)