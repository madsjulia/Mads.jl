# Test for the Mads IO system

import Mads
import Base.Test

@Base.Test.testset "Filename" begin
	test_dir = "filename_testing"
	jpath(file) = joinpath(test_dir, file)
	
	curdir = pwd()
	Mads.rmdir(test_dir)
	Mads.mkdir(test_dir)
	
	touch(jpath("a-v01.mads"))
	touch(jpath("a-v02.mads"))
	touch(jpath("a-v03.mads"))

	# Verify that getnextmadsfilename returns the most recently modified file
	@Base.Test.test Mads.getnextmadsfilename(jpath("a-v01.mads")) == jpath("a-v03.mads")
	sleep(1)
	touch(jpath("a-v02.mads"))
	@Base.Test.test Mads.getnextmadsfilename(jpath("a-v01.mads")) == jpath("a-v02.mads")
	
	# Verify that Mads parses filename prefixes and extensions
	touch(jpath("test.file.name.txt"))
	@Base.Test.test Mads.getrootname(jpath("test.file.name.txt")) == jpath("test")
	@Base.Test.test Mads.getextension(jpath("a-v01.mads")) == "mads"

	Mads.rmdir("filename_testing")

end