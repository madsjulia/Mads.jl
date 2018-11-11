if VERSION >= v"0.7.0-"
    using Pkg
    show(stdout, "text/plain", Pkg.installed())
    println()
else
    for line in split(strip(readstring("REQUIRE")), '\n')[2:end]
        name = split(line)[1]
        println(name, "\t", Pkg.installed(name))
    end
end