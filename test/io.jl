arr = [["a",1] ["b",1.6]]

Mads.dumpasciifile("a.dat", arr)
arr1 = Mads.loadasciifile("a.dat")
# @assert arr==arr1
if isfile("a.dat")
    rm("a.dat")
end

Mads.dumpjsonfile("a.json", arr)
arr1 = Mads.loadjsonfile("a.json")
# @assert arr==arr1
if isfile("a.json")
    rm("a.json")
end

Mads.dumpyamlfile("a.yaml", arr)
arr1 = Mads.loadyamlfile("a.yaml")
# @assert arr==arr1
if isfile("a.yaml")
    rm("a.yaml")
end

Mads.dumpyamlfile("a.yaml", arr, julia=true)
arr1 = Mads.loadyamlfile("a.yaml")
# @assert arr==arr1
if isfile("a.yaml")
    rm("a.yaml")
end

Mads.searchdir("a")
Mads.searchdir(r"a")