arr = [["a",1] ["b",1.6]]

Mads.dumpasciifile("a.dat", arr)
arr1 = Mads.loadasciifile("a.dat")
# @assert arr==arr1
run(`bash -c "rm -f a.dat"`)

Mads.dumpjsonfile("a.json", arr)
arr1 = Mads.loadjsonfile("a.json")
# @assert arr==arr1
run(`bash -c "rm -f a.json"`)

Mads.dumpyamlfile("a.yaml", arr)
arr1 = Mads.loadyamlfile("a.yaml")
# @assert arr==arr1
run(`bash -c "rm -f a.yaml"`)