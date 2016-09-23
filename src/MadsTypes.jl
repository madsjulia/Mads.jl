import Compat
import Compat.String

## Types necessary for SVR
type svrOutput
	alpha::Array{Float64,1}
	b::Float64
	kernel::Function
	kernelType::String
	train_data::Array{Float64, 2}
	varargin::Array

	svrOutput(alpha::Array{Float64,1}, b::Float64, kernel::Function, kernelType::String, train_data::Array{Float64, 2}, varargin::Array) = new(alpha, b, kernel, kernelType, train_data, varargin); # constructor for the type
end

type svrFeature
	feature::Array{Float64,1}
end
