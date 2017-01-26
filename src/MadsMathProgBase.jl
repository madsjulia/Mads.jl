import MathProgBase

type MadsModel <: MathProgBase.AbstractNLPEvaluator
end

"Mads execution using MathProgBase"
function madsmathprogbase(madsdata::Associative=Dict())
	function MathProgBase.initialize(d::MadsModel, requested_features::Vector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	MathProgBase.features_available(d::MadsModel) = [:Grad, :Jac]
	function MathProgBase.eval_f(d::MadsModel, p::Vector)
		r = Mads.forward(madsdata, p)
		return Mads.of(madsdata, vec(r))
	end
	function MathProgBase.eval_grad_f(d::MadsModel, grad_f::Vector, p::Vector)
		grad_f[1] = t[5]^p[4]
		grad_f[2] = t[5]
		grad_f[3] = 1
		grad_f[4] = p[1] * (t[5]^p[4]) * log(t[5])
	end
	function MathProgBase.eval_g(d::MadsModel, o::Vector, p::Vector)
		for i = 1:no
			o[i] = p[1] * (t[i]^p[4]) + p[2] * t[i] + p[3]
		end
	end
	MathProgBase.hesslag_structure(d::MadsModel) = Int[],Int[]
	MathProgBase.eval_hesslag(d::MadsModel, H, p, σ, μ) = nothing
	#=
	MathProgBase.jac_structure(d::MadsModel) = Int[],Int[]
	MathProgBase.eval_jac_g(d::MadsModel, J, p) = nothing
	=#
	MathProgBase.jac_structure(d::MadsModel) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
	function MathProgBase.eval_jac_g(d::MadsModel, J::Vector, p::Vector)
		ji = 1
		for i = 1:no
			J[ji + 0] = t[i]^p[4]
			J[ji + 1] = t[i]
			J[ji + 2] = 1
			J[ji + 3] = p[1] * (t[i]^p[4]) * log(t[i])
			ji += 4
		end
	end
end