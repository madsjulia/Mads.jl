arr = [["a",1] ["b",1.6]]

workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
    workdir = Mads.madsdir * "/../test/"
end

Mads.dumpasciifile(workdir * "a.dat", arr)
arr1 = Mads.loadasciifile(workdir * "a.dat")
# @assert arr==arr1
if isfile(workdir * "a.dat")
    rm(workdir * "a.dat")
end

Mads.dumpjsonfile(workdir * "a.json", arr)
arr1 = Mads.loadjsonfile(workdir * "a.json")
# @assert arr==arr1
if isfile(workdir * "a.json")
    rm(workdir * "a.json")
end

Mads.dumpyamlfile(workdir * "a.yaml", arr)
arr1 = Mads.loadyamlfile(workdir * "a.yaml")
# @assert arr==arr1
if isfile(workdir * "a.yaml")
    rm(workdir * "a.yaml")
end

Mads.dumpyamlfile(workdir * "a.yaml", arr, julia=true)
arr1 = Mads.loadyamlfile(workdir * "a.yaml")
# @assert arr==arr1
if isfile(workdir * "a.yaml")
    rm(workdir * "a.yaml")
end

Mads.searchdir("a", path = workdir)
Mads.searchdir(r"a", path = workdir)