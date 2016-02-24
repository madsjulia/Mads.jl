Model Coupling
--------------

MADS can be coupled with any internal or external model. The model coupling is defined in the MADS problem dictionary. The expectations is that for a given set of model inputs, the model will produce a model output that will be provided to MADS. The fields in the MADS problem dictionary that can be used to define the model coupling are:

- `Model` : Julia model defined in an external Julia file.

- `MADS model` : Julia model defined in an external Julia file using information from the MADS problem dictionary.

- `Julia model` : Julia model defined internally (already in the Julia workspace).

- `Command` : external model executed by an UNIX command or script.

- `Julia command` : external model executed by a Julia script. The Julia script is defined in an external Julia file.

Both `Command` and `Julia command` can use different approaches to pass model parameters to the external model. Only `Command` uses different approaches to get back the model outputs. The script defined under `Julia command` parses the model outputs using Julia. The available options for writing model inputs and reading model outputs are as follows.

* Options for writing model inputs:
    + `Templates` : template files for writing model input files as defined at [mads.lanl.gov](http://mads.lanl.gov)
    + `ASCIIParameters` : model parameters written in a ASCII file
    + `JLDParameters` : model parameters written in a JLD file
    + `YAMLParameters` : model parameters written in a YAML file
    + `JSONParameters` : model parameters written in a JSON file

* Options for reading model outputs:
    + `Instructions` : instruction files for reading model output files as defined at mads.lanl.gov](http://mads.lanl.gov)
    + `ASCIIPredictions` : model predictions read from a ASCII file
    + `JLDPredictions` : model predictions read from a JLD file
    + `YAMLPredictions` : model predictions read from a YAML file
    + `JSONPredictions` : model predictions read from a JSON file