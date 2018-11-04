import Mads
import Test

Mads.madsinfo("Levenberg-Marquardt optimization of an internal problem:")
problemdir = dirname(Base.source_path())

md = Mads.loadmadsfile(joinpath(problemdir, "internal-linearmodel.mads"))
results = Mads.calibrate(md, maxEval=2, maxJacobians=1, np_lambda=1)

@Test.test isapprox(results[1]["a"], 3.80770942, atol=1e-6)
@Test.test isapprox(results[1]["b"], 6.15636776, atol=1e-6)

return