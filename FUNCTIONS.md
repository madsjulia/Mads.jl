MADS Functions
--------------------

MADS includes several Modules. The modules include numerous functions. To list all the available functions execute:

```julia
Mads.functions()
```

To list all the functions in a module, do:


```julia
Mads.functions(BIGUQ)
```

To list all the functions containing `get`, execute:

```julia
Mads.functions("get")
Mads.functions(Mads, "get")
```