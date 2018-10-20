import Mads
import Base.Test

workdir = "filename_testing"
@Mads.stderrcapture function jpath(file::String)
	joinpath(workdir, file)
end

curdir = pwd()
Mads.mdir()
cd(curdir)
Mads.rmdir(workdir)
Mads.mkdir(workdir)

touch(jpath("a-v01.mads"))
touch(jpath("a-v02.mads"))
touch(jpath("a-v03.mads"))

@Base.Test.testset "Filename" begin
	# Verify that getnextmadsfilename returns the most recently modified file
	@Base.Test.test Mads.getnextmadsfilename(jpath("a-v01.mads")) == jpath("a-v03.mads")
	sleep(1)
	touch(jpath("a-v02.mads"))
	@Base.Test.test Mads.getnextmadsfilename(jpath("a-v01.mads")) == jpath("a-v02.mads")

	# Verify that Mads parses filename prefixes and extensions
	touch(jpath("test.file.name.txt"))
	@Base.Test.test Mads.getrootname(jpath("test.file.name.txt")) == jpath("test")
	@Base.Test.test Mads.getextension(jpath("a-v01.mads")) == "mads"
end

Mads.rmdir(workdir)

:passed