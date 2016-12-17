arr = [["a",1] ["b",1.6]]

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
    workdir = joinpath(Mads.madsdir, "..", "test")
end

Mads.dumpasciifile(joinpath(workdir, "a.dat"), arr)
arr1 = Mads.loadasciifile(joinpath(workdir, "a.dat"))
# @assert arr==arr1
Mads.rmfile(joinpath(workdir, "a.dat"))

Mads.dumpjsonfile(joinpath(workdir, "a.json"), arr)
arr1 = Mads.loadjsonfile(joinpath(workdir, "a.json"))
# @assert arr==arr1
Mads.rmfile(joinpath(workdir, "a.json"))

Mads.dumpyamlfile(joinpath(workdir, "a.yaml"), arr)
arr1 = Mads.loadyamlfile(joinpath(workdir, "a.yaml"))
# @assert arr==arr1
Mads.rmfile(joinpath(workdir, "a.yaml"))

Mads.dumpyamlfile(joinpath(workdir, "a.yaml"), arr, julia=true)
arr1 = Mads.loadyamlfile(joinpath(workdir, "a.yaml"))
# @assert arr==arr1
Mads.rmfile(joinpath(workdir, "a.yaml"))

Mads.searchdir("a", path = workdir)
Mads.searchdir(r"a", path = workdir)

Mads.dumpasciifile(joinpath(workdir, "root_testing.extension_testing"), arr)
Mads.rmfiles_ext("extension_testing"; path = workdir)
Mads.dumpasciifile(joinpath(workdir, "root_testing.extension_testing"), arr)
Mads.rmfiles_root("root_testing"; path = workdir)