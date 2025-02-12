import Mads
import Test
import Printf

if isdefined(Mads, :runcmd)
end

Mads.restarton()
Mads.restartoff()

if Mads.create_tests
	Mads.create_tests_off()
	Mads.create_tests_on()
else
	Mads.create_tests_on()
	Mads.create_tests_off()
end
if Mads.long_tests
	Mads.long_tests_off()
	Mads.long_tests_on()
else
	Mads.long_tests_on()
	Mads.long_tests_off()
end

Mads.setdebuglevel(1)
Mads.resetmodelruns()

Mads.functions(; quiet=true)

Mads.loadmadsproblem("unknown");
Mads.loadmadsproblem("polynomial");

Mads.functions(:ModuleThatDoesNotExist)
Mads.functions("createmadsproblem");
Mads.functions(r"parameter")
Mads.functions(Mads, "loadmadsfile");
Mads.functions(Mads, r"is.*par");

quiet_status = Mads.quiet
Mads.quietoff()

try
	# Mads.runcmd(`julia -h`; quiet=true)
catch
	Mads.madswarn("Julia executable needs to be in the executable search path! Some of the tests may fail!")
end

try
	target = joinpath(Mads.dir, "Profile.toml")
	link = joinpath(Mads.dir, "Profile-link.toml")
	Mads.rmfile(link)
	symlink(target, link)
	rm(link)
catch
	Mads.madswarn("Symbolic links cannot be created!")
	if Sys.iswindows()
		Mads.madswarn("Microsoft Windows requires to execute Julia as an administrator or in a Windows developers mode to be able to create links.")
	else
		Mads.madswarn("If you are using a network drive, symbolic links may not be supported.")
	end
end

Mads.stdouterrcaptureon()

Mads.printerrormsg("a")
madsoutput("a")
Mads.madsdebug("a")
madsinfo("Testing ...")
Mads.help()
Mads.copyright()
if length(ARGS) < 1
	push!(ARGS, "testing")
else
	ARGS[1] = "testing"
end
# include(joinpath("..", "src", "madsjl.jl"))
# rm("madsjl.cmdline_hist")

Mads.setexecutionwaittime(0.)
if Sys.iswindows()
	Mads.runcmd("dir $(Mads.dir)")
	Mads.runcmd("dir $(Mads.dir)"; pipe=true)
	Mads.runcmd("dir $(Mads.dir)"; waittime=10.)
else
	Mads.runcmd("ls $(Mads.dir)")
	Mads.runcmd("ls $(Mads.dir)"; pipe=true)
	Mads.runcmd("ls $(Mads.dir)"; waittime=10.)
end

Mads.stdouterrcaptureoff()

Mads.transposevector(["a"; "b"])
Mads.transposematrix(["a" "b"])

if !haskey(ENV, "MADS_NO_GADFLY")
	Mads.graphoff()
	Mads.plotwellSAresults(Dict(), Dict())
	Mads.plotwellSAresults(Dict("W"=>Dict()), Dict(), "w1")
	Mads.plotwellSAresults(Dict("Wells"=>Dict()), Dict(), "w1")

	Mads.plotobsSAresults(Dict(), Dict())
	Mads.setplotfileformat("a.ps", "")
	Mads.setplotfileformat("a", "EPS")
	defaultplotformat = Mads.graphbackend
	Mads.setdefaultplotformat("TIFF")
	Mads.setdefaultplotformat("EPS")
	Mads.setdefaultplotformat("SVG")
	Mads.setdefaultplotformat(defaultplotformat)
	Mads.display("mads.png")
	Mads.graphon()
end

Mads.addkeyword!(Dict(), "ssdr")
Mads.addkeyword!(Dict("Problem"=>"ssdr"), "ssdr")
Mads.addkeyword!(Dict{String,Any}("Problem"=>"ssdr"), "Problem", "ssdr2")
Mads.addkeyword!(Dict("Problem"=>["ssdr2","paranoid"]), "ssdr")
Mads.addkeyword!(Dict("Problem"=>Dict("ssdr2"=>true)), "ssdr")

Mads.deletekeyword!(Dict(), "ssdr")
Mads.deletekeyword!(Dict("Problem"=>"ssdr"), "ssdr")
Mads.deletekeyword!(Dict{String,Any}("Problem"=>"ssdr"), "Problem", "ssdr")
Mads.deletekeyword!(Dict("Problem"=>["ssdr2","paranoid"]), "ssdr")
Mads.deletekeyword!(Dict("Problem"=>Dict("ssdr2"=>true)), "ssdr")
Mads.deletekeyword!(Dict("Problem"=>Dict("ssdr"=>true)), "Problem", "ssdr")
Mads.deletekeyword!(Dict("Problem"=>["ssdr","paranoid"]), "Problem", "ssdr")

# Mads.pkgversion_old("ModuleThatDoesNotExist") # this captures output

Mads.quieton()
if quiet_status
	Mads.quieton()
else
	Mads.quietoff()
end

Mads.setverbositylevel(1)

graph_status = Mads.graphoutput
Mads.graphoff()
Mads.graphon()
if graph_status
	Mads.graphon()
else
	Mads.graphoff()
end

@Test.test Mads.haskeyword(Dict("Problem"=>"ssdr"),"ssdr") == true
@Test.test Mads.haskeyword(Dict("Problem"=>Dict("ssdr"=>true)), "ssdr") == true
@Test.test Mads.haskeyword(Dict("Problem"=>["ssdr","paranoid"]), "ssdr") == true
@Test.test Mads.haskeyword(Dict("Problem"=>0.1), "Problem", "ssdr") == false

@Test.test Mads.getdir("a.mads") == "."
@Test.test Mads.getdir("test/a.mads") == "test"

Mads.createobservations(4, 2; filename="a.inst")
Mads.rmfile("a.inst")

md = Dict()
md["Parameters"] = first(Mads.createparameters([1,1,1,1]; key=["a", "b", "c", "n"], dist=["Uniform(-10, 10)", "Uniform(-10, 10)", "Uniform(-5, 5)", "Uniform(0, 3)"]))
md["Observations"] = Mads.createobservations([0,1.1,1.9,3.1,3.9,5]; weight=[100,100,100,100,10,0], time=[0,1,2,3,4,5], dist=["Uniform(0, 1)", "Uniform(0, 2)", "Uniform(1, 3)", "Uniform(2, 4)", "Uniform(3, 5)", "Uniform(4, 6)"])
Mads.setmodel!(md, exp)

Mads.getsindx(Dict("Problem"=>Dict("sindx"=>"0.001")))
Mads.setsindx!(Dict("Problem"=>Dict("sindx"=>0.001)), 0.1)

# Mads.status()
Mads.set_nprocs_per_task(1)
Mads.setdir()
Mads.setprocs(; veryquiet=true)
Mads.setprocs(1)
Mads.parsenodenames("wc[096-157,160,175]")

Mads.graphoff()
Mads.plotseries(rand(4,5), "test.png"; combined=false)
Mads.plotseries(rand(4,5), "test.png")
if isdefined(Mads, :display)
	Mads.display("test.png")
end
Mads.rmfile("test.png")
Mads.graphon()

deleteat!(ARGS, 1)

@Test.testset "Unique/Nonunique functions" begin
	@Test.test Mads.unique_indices([1,2,3,3]) == [1,2,3]
	@Test.test Mads.nonunique_indices([1,2,3,3]) == [4]
	@Test.test Mads.unique_mask([1,2,3,3]) == [true, true, true, false]
	@Test.test Mads.nonunique_mask([1,2,3,3]) == [false, false, false, true]
	@Test.test Mads.unique([1,2,3,3]) == [1,2,3]
	@Test.test Mads.nonunique([1,2,3,3]) == [3]
end

:passed