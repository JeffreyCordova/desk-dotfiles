if isdir(Pkg.dir("OhMyREPL"))
    @eval using OhMyREPL
else
    warn("OhMyREPL not install")
end

