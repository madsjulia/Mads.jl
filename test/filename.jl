Mads.rmdir("finename_testing")
curdir = pwd()
mkdir("finename_testing")
cd("finename_testing")
touch("a-v01.mads")
touch("a-v02.mads")
touch("a-v03.mads")
@Base.Test.test Mads.getnextmadsfilename("a-v01.mads") == "./a-v03.mads"
sleep(1)
touch("a-v02.mads")
@Base.Test.test Mads.getnextmadsfilename("a-v01.mads") == "./a-v02.mads"
cd(curdir)
Mads.rmdir("finename_testing")