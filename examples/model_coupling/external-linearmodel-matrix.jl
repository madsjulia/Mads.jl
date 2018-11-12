using DelimitedFiles

i = open("matrix.dat", "r")
param = readdlm(i)
close(i)
a1 = param[1,1]
a2 = param[1,2]
b1 = param[2,1]
b2 = param[2,2]
f1(t) = a1 * t - b1 # a * t - b
f2(t) = a2 * t - b2 # a * t - b
times = collect(1:14)
p1 = f1.(times)
p2 = f2.(times)
DelimitedFiles.writedlm("model_output.dat", [times times p1 p2])