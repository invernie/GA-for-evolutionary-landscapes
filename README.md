# GA-for-evolutionary-landscapes
This repository contains the files used for the preprint "Genetic Algorithms as a method to study adaptive walks in biological landscapes" (available at https://doi.org/10.1101/2020.07.29.226324).


The code files in this repository were written in Python 2 and compiled using Cython (`.pyx` extension). The files are organised modularly.  
  
## Simulation files  
  
 `poolcode.pyx` is the top-level code distributing simulation runs across cores (simulations are split across one parameter dimension, _a_, for convenience). It calls functions in the `analysePar.pyx` module.
 
 `analysePar.pyx` contains five functions, each making a call to a sub function running the model with a different selection methods and organising runs across all numerical model parameters (except parameter a, which is used for the across-core split). The split into five functions is necessary because different selection methods require different parameters and they need to be called and assigned to object types separately. This file also contains some functions calculating time performance measures.
  
 `SPS_ktour.pyx`, `SPS_rank.pyx`, `SPS_rwheel.pyx` and `SPS_truncation.pyx` are the modules containing and running the sequence of algorithm processes. Two of these processes are coded in separate submodules: `FitEval.pyx` evaluates the fitness of each solution (_i.e._, it plays the actual game) and `Selection.pyx` selects the solutions that will father (or mother) the next generation, based on the selection method.  
  
 `Mutation.pyx` is called within the `Selection` module and generates mutations in the newly-born offspring solutions.  
   
## Result analysis files
  
`fishES.pyx` extracts some statistics (average and standard deviation) on the frequency of each solution type across each model parameter. Results are saved in selection-method-specific csv files.  
  
