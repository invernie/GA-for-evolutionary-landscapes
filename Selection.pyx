from __future__ import division
import random, array
import numpy as np

import Mutation

#Careful: Population is an np.array and as such allocated a space in memory across scope, which is then modified every time an instance of Population is called and modified at any level. Pay attention to when original object needs or needs not be modified (copy())

def truncation(Population, thr, mut, N, mu):

    #no need to assign type to variables where type can be deduced from computation (integers are exception)
    cdef int n
    newGeneration = list()

    #sorts population from highest to lowest in fitness
    Population[::-1].sort(order = 'fit')
    parentPool = Population[0:thr]
	
    for n in range(N):
        parent = random.choice(parentPool ['s']).copy()

        #runs mutation from Mutation module
        if mut:
            parent = Mutation.perchromosome(parent, mu)
        else:
            parent = Mutation.uniform(parent, mu)

        newGeneration.append(parent)

    return newGeneration


def ktournament(Population, N, K, alpha, mut, mu):

    cdef int k, n
    cdef float prob

    newGeneration = list()

    for n in range(N):
        contestants = random.sample(Population,K)
        #sorts contestants from highest to lowest in fitness
        contestants.sort(key = lambda fit: fit[1], reverse = True)
        k = 1
        prob = random.uniform(0,1)
        while prob > alpha and k < K:
            k += 1
            prob = random.uniform(0,1)
        parent = contestants [k-1] ['s'].copy()
	
        #run mutation from Mutation module
        if mut:
            Mutation.perchromosome(parent, mu)
        else:
            Mutation.uniform(parent, mu)

        newGeneration.append(parent)

    return newGeneration


def ranking(Population, M, N, rf, O, mut, mu):

    cdef int l, n, m
    cdef float sumExp, c, Max, Min

    newGeneration = list()

    #assignment algorithm
    Population.sort(order = 'fit')
    fitnessList = Population ['fit'].copy()
    if rf: #exponential
        for m in range(M):
			c = O
            Population [m]['fit'] = c**(M-m-1)

    else: #linear
        Max = 2*O/M
        Min = 2*N/M - Max
        for m in range(M):
            Population [m]['fit'] = Min + (Max - Min)*(m)/(M-1)

    popRanked = Population ['fit'].copy()

    #sampling algorithm - implemented as roulette-wheel
    #for future runs/work: population should be shuffled each round, to avoid fittest ind driving neighbours to reproduction ("linkage dis" effect)
    np.random.shuffle(Population)
    for n in range(N):
        sumExp = 0
        l = 0
        r = random.uniform(0,N)
        while sumExp < r:
            if l==M:
                l = 0
            sumExp += Population [l]['fit']
            l += 1
            
        parent = Population [l-1]['s'].copy()

        #run mutation from Mutation module
        if mut:
            Mutation.perchromosome(parent, mu)
        else:
            Mutation.uniform(parent, mu)

        newGeneration.append(parent)

    return newGeneration

def roulettewheel(Population, M, N, w, mut, mu):

    cdef int l, n
    cdef float sumExp

    newGeneration = list()

    FitnessList = np.zeros(M, dtype = 'float16')

    np.random.shuffle(Population)
    FitnessList = Population ['fit'].copy()
    mean = sum(FitnessList)/M
    sd = np.std(FitnessList)
    if sd != 0:
        FitnessList = (1+(FitnessList-mean)/(2*sd))*w*N/M
    else:
        FitnessList = 1.0

    for n in range(N):
        sumExp = 0
        l = 0
        r = random.uniform(0,N)
        while sumExp < r:
            if l==M:
                l = 0
            sumExp += FitnessList [l]
            l += 1
            
        parent = Population [l-1] ['s'].copy()

	#run mutation from Mutation module
        if mut:
            Mutation.perchromosome(parent, mu)
        else:
            Mutation.uniform(parent, mu)

        newGeneration.append(parent)
    
    return newGeneration

    
        
        









