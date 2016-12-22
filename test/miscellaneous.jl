import Base.Test
import Compat

if isdefined(Mads, :runcmd)
end

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

originalSTDOUT = STDOUT;
(outRead, outWrite) = redirect_stdout();
if VERSION < v"0.5"
	reader = @async readall(outRead);
else
	reader = @async readstring(outRead);
end

quiet_status = Mads.quiet
Mads.quietoff()

try
	run(pipeline(`julia -h`, stdout=DevNull, stderr=DevNull))
catch
	Mads.madscritical("Julia executable needs to be in the executable search path!")
end

try
	Mads.rmfile("test-create-symbolic-link")
	symlink(Pkg.dir("Mads"), "test-create-symbolic-link")
	rm("test-create-symbolic-link")
catch
	if Mads.madswindows
		Mads.madscritical("Symbolic links cannot be created! Microsoft Windows require to execute julia as administrator.")
	else
		Mads.madscritical("Symbolic links cannot be created!")
	end
end

Mads.madsoutput("a")
Mads.madsdebug("a")
Mads.madsinfo("Testing ...")
Mads.help()
Mads.copyright()
if length(ARGS) < 1
	push!(ARGS, "testing")
else
	ARGS[1] = "testing"
end
include("../src/madsjl.jl")
rm("madsjl.cmdline_hist")
Mads.functions()
Mads.functions("createmadsproblem")
Mads.functions(Mads, "loadmadsfile")
if isdefined(Mads, :runcmd)
	if Mads.madswindows
		run(`cmd /C dir $(Pkg.dir("Mads"))`)
	else
		Mads.runcmd(`ls $(Pkg.dir("Mads"))`)
	end
end
# Mads.create_documentation()

redirect_stdout(originalSTDOUT);
close(outWrite);
output = wait(reader);
close(outRead);

Mads.quieton()
if quiet_status
	Mads.quieton()
else
	Mads.quietoff()
end

Mads.setverbositylevel(1)

if !haskey(ENV, "MADS_NO_GADFLY")
	Mads.setplotfileformat("a.ps", "")
	Mads.setplotfileformat("a", "EPS")
	Mads.setdefaultplotformat("TIFF")
	Mads.setdefaultplotformat("EPS")
	Mads.setdefaultplotformat("SVG")
	Mads.display("mads.png")
end

if isdefined(:Gadfly)
	Mads.plotseries(rand(4,5), "test.png", combined=false)
	Mads.plotseries(rand(4,5), "test.png")
	if isdefined(Mads, :display)
		Mads.display("test.png")
	end
	Mads.rmfile("test.png")
end

graph_status = Mads.graphoutput
Mads.graphoff()
Mads.graphon()
if graph_status
	Mads.graphon()
else
	Mads.graphoff()
end

@Base.Test.test Mads.haskeyword(Dict("Problem"=>"ssdr"),"ssdr") == true
@Base.Test.test Mads.haskeyword(Dict("Problem"=>Dict("ssdr"=>true)), "ssdr") == true
@Base.Test.test Mads.haskeyword(Dict("Problem"=>["ssdr","paranoid"]), "ssdr") == true

Mads.addkeyword!(Dict(), "ssdr")
Mads.addkeyword!(Dict("Problem"=>"ssdr"), "ssdr")
Mads.addkeyword!(Dict("Problem"=>["ssdr2","paranoid"]), "ssdr")
Mads.addkeyword!(Dict("Problem"=>Dict("ssdr2"=>true)), "ssdr")

if !haskey(ENV, "MADS_TRAVIS")
	Mads.status()
	Mads.set_nprocs_per_task(1)
	Mads.setdir()
	Mads.setprocs()
	Mads.setprocs(1)
	Mads.parsenodenames("wc[096-157,160,175]");
end