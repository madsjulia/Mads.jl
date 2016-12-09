arr = [["a",1] ["b",1.6]]

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
    workdir = Mads.madsdir * "/../test/"
end

Mads.dumpasciifile(workdir * "a.dat", arr)
arr1 = Mads.loadasciifile(workdir * "a.dat")
# @assert arr==arr1
Mads.rmfile(workdir * "a.dat")

Mads.dumpjsonfile(workdir * "a.json", arr)
arr1 = Mads.loadjsonfile(workdir * "a.json")
# @assert arr==arr1
Mads.rmfile(workdir * "a.json")

Mads.dumpyamlfile(workdir * "a.yaml", arr)
arr1 = Mads.loadyamlfile(workdir * "a.yaml")
# @assert arr==arr1
Mads.rmfile(workdir * "a.yaml")

Mads.dumpyamlfile(workdir * "a.yaml", arr, julia=true)
arr1 = Mads.loadyamlfile(workdir * "a.yaml")
# @assert arr==arr1
Mads.rmfile(workdir * "a.yaml")

Mads.searchdir("a", path = workdir)
Mads.searchdir(r"a", path = workdir)

Mads.dumpasciifile(workdir * "root_testing.extension_testing", arr)
Mads.rmfiles_ext("extension_testing"; path = workdir)
Mads.dumpasciifile(workdir * "root_testing.extension_testing", arr)
Mads.rmfiles_root("root_testing"; path = workdir)