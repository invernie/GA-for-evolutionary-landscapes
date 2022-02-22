#!/usr/bin/env python

#import modules
from __future__ import division
import random , itertools, time, shelve
import numpy as np
import  sys
sys.path.append('/home/edith/Documents/python_srpt')
import FitEval, Selection

cdef int seed, mut, rpl, M, N, K
cdef float a, mu
random.seed(seed)
np.random.seed(seed)


def run(seed, mut, rpl, M, N, a, mu, K):
    cdef int y, m, rec, s, A
    cdef float alpha

    alpha = 1.0

    #create bit and log file
    filepath = '/home/edith/Documents/GA/results/kt/' 
    filename = "kt-a" + str(int(a*100)) + "M" + str(M) + '-N' + str(N) + '-k' + str(K) + '-alp' + str(int(alpha*100)) + "-"
    if mut:
        mtype = "pc"
    else:
        mtype = "pl"
    filename = filename + mtype + str(int(mu*1000))

    if rpl:
        rtype = "fifo"
    else:
        rtype = "det"
    filename = filename + '-' + rtype + '-'
    filename = filename + str(seed)

    bitfilename = filepath + filename
    #logfilename = filepath + "log_" + filename + ".txt"
    #sys.stderr = open(logfilename, 'w+')
    



    #create all possible strategies
    """Chromosome: [0:1] = donor strategy, signal received [0] or signal not received [1]; [2:3] = closely related beneficiary, thirsty [2] or healthy [3]; 
    loosely related beneficiary, thirsty [4] or healthy [5] ; fitness [6]
       0 = don't give/don't signal; 1 = give/signal """
    #ancestral state: don't signal, don't signal, don't give
    Ancestor = [0,0,0,0,0,0]
    strategyList = map(list,itertools.product([0,1] , repeat = 6))
    sLArray = np.array(strategyList)
    sString = [str(x) for x in sLArray]
    strategyPool = [xx for xx in strategyList if xx != Ancestor]


    #create population as Numpy array
    Population = np.zeros(M, dtype = '6int8, float16, int64')
    Population.dtype.names = ('s', 'fit','id')
    if rpl == 1:
        Population ['id'] = range(0,M)
    #fill in 'strategy list' component of population
    A = M-int(round(a*M))
    Chromosomes = [random.choice(strategyPool) for _ in range(A)]
    Population [0:A] ['s'] = Chromosomes
    #fill in 'ancestral' component
    if A < M :
        ancestralSeed = map(list,itertools.repeat(Ancestor,int(round(a*M))))
        Population [A:M] ['s'] = ancestralSeed


    #variables for simulation termination, duration and performance
    yTot = 500
    yRec = 50
    freqList = np.zeros(yRec, dtype = '64float16')
    fitList = np.zeros(yRec, dtype = str(M) + 'float64')
    aveFit = np.zeros(yTot, dtype = '2float64')
    aveBest = np.zeros(yTot, dtype = 'float64')
    y = 0
    rec = 0 
    start = time.time()



    while (y < yTot ): #condition until which the simulation runs

        #run fitness evaluation from FitEval module
        Population = FitEval.fitnessrounds(Population, M)


        #run selection from Selection module
        Offspring = Selection.ktournament(Population, N, K, alpha, mut, mu)
    

        #run replacement routine
        if N != M:

            if rpl == 0: #deterministic replacement
                Population.sort(order = 'fit')
            
            else:       #FIFO replacement
                Population[::-1].sort(order = 'id')

            Population [0:N] ['s'] = Offspring
            Population [0:N] ['id'] = range(M+N*y,M+N*(y+1))
                
        else:
            Population ['s'] = Offspring


        #collect values during recording period
        if y >= yTot - yRec :
            #calculate strategy frequency
            '''np and other count and unique functions look at each element of a subarray list element 
            and count individually (i.e. for each s, counting occurrencies of 0s and 1s, as the lowest-level elements)
            workaround: convert to strings'''
            pString = [str(xxx) for xxx in Population ['s']] 
            for s in range(64):
                freqList [rec] [s] = pString.count(sString[s])
            freqList [rec] = freqList [rec]/M

            #record fitness values
            for m in range(M):
                fitList [rec] [m] = Population [m] ['fit']

            rec += 1

        #collect values for full simulation length:
        #average population fitness at time y (online performance)
        aveFit [y] [0] = sum(Population ['fit']/M)
        #population.std of population fitness at time t
        aveFit [y] [1] = np.std(Population ['fit'])
        #highest fitness in population (offline performance)
        aveBest [y] = np.argmax(Population ['fit'])

    
        #set new population's fitness to 0
        Population ['fit'] = 0
        
        
        #count number of sim years
        y += 1



    #save final data and performance measures
    totT = time.time()-start
    my_shelf = shelve.open(bitfilename, 'n')
    try:
        my_shelf['Population'] = Population
        my_shelf['Chromosomes'] = Chromosomes
        my_shelf['A'] = A
        my_shelf['K'] = K
        my_shelf['alpha'] = alpha
        my_shelf['Offspring'] = Offspring
        my_shelf['y'] = y
        my_shelf['freqList'] = freqList
        my_shelf['fitList'] = fitList
        my_shelf['aveFit'] = aveFit
        my_shelf['aveBest'] = aveBest
        my_shelf['totT'] = totT
        my_shelf['strategyList'] = strategyList
    except TypeError:
        print('ERROR shelving: {0}')
    my_shelf.close()

    #sys.stderr.close()
    #sys.stderr = sys.__stderr__
