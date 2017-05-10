# Test for the Mads IO system

import Mads
import Base.Test

@Base.Test.testset "Filename" begin
    test_dir = "filename_testing"
    curdir = pwd()
    Mads.rmdir(test_dir)
    Mads.mkdir(test_dir)
    
    touch(joinpath(test_dir, "a-v01.mads"))
    touch(joinpath(test_dir, "a-v02.mads"))
    touch(joinpath(test_dir, "a-v03.mads"))

    # Verify that getnextmadsfilename returns the most recently modified file
    @Base.Test.test Mads.getnextmadsfilename(joinpath(test_dir, "a-v01.mads")) == joinpath(test_dir, "a-v03.mads")
    sleep(1)
    touch(joinpath(test_dir, "a-v02.mads"))
    @Base.Test.test Mads.getnextmadsfilename(joinpath(test_dir, "a-v01.mads")) == joinpath(test_dir, "a-v02.mads")
    
    # Verify that Mads parses filename prefixes and extensions
    touch(joinpath(test_dir, "test.file.name.txt"))
    @Base.Test.test Mads.getrootname(joinpath(test_dir, "test.file.name.txt")) == joinpath(test_dir, "test")
    @Base.Test.test Mads.getextension(joinpath(test_dir, "a-v01.mads")) == "mads"

    Mads.rmdir("filename_testing")
    println(Mads.getmadsinputfile())

end