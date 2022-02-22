import random
import numpy as np

def fitnessrounds(Population, M):

    cdef int m, rounds, role, hState, rState, dStratSig, dStratnoSig, signal
    cdef float fitness 
    cdef float r
    cdef float t1 = 0.4
    cdef float t2 = 0.1
    cdef float r1 = 0.5
    cdef float r2 = 0.2
    cdef float Sb = 0.8
    cdef float Sd = 0.8


    for m in range(M): #Python creates a copy of the object in loops
        
        """creates "opponent pool" containing all solutions in the populations except for the one under evaluation 
        (i.e. a solution can still interact with a copy of itself if more than one present in the population) """
        popPool = Population [np.arange(len(Population)) != m]
        evStrat = Population [m] ['s']
        fitness = 0
 
        for rounds in range(5):
            opponent = random.choice(popPool)
            #evaluee plays donor (0) or beneficiary (1) role
            role = random.uniform(0,1) <= 0.5
            #beneficiary thirsty (0) or healthy (1) (freq. as in Johnstone & Grafen, 1993)
            hState = random.uniform(0,1) <= 0.6
            """evaluee and opponent share relatedness r1 (closely related - 1) or r2 (loosely related - 0)
            (freq. as in Johnstone & Grafen, 1993)"""
            rState = random.uniform(0,1) <= 0.9
            if rState:
                r = r1 #closely rel
                t = t1
            else:
                r = r2 #loosely rel
                t = t2

            opStrat = opponent ['s']
            #play "beneficiary" substrategy
            if role:
                dStratSig = opStrat [0]
                dStratnoSig = opStrat [1]
                signal = evStrat [2 + 2*rState + hState]
                fitness += Sb*hState * (1-t*signal) + r + ( signal*dStratSig + (1-signal)*dStratnoSig ) * ( (1-Sb*hState) * (1-t*signal) - r*(1-Sd) )

            else: #play "donor" substrategy
                dStratSig = evStrat [0]
                dStratnoSig = evStrat [1]
                signal = opStrat [2 + 2*rState + hState]
                fitness += 1 + r*Sb*(1-t*signal)*hState - ( signal*dStratSig + (1-signal)*dStratnoSig ) * ( 1-Sd - r*(1-Sb*hState)*(1-t*signal) )

        #average fitness across rounds is output
        Population [m] ['fit'] = fitness/5

    return Population
