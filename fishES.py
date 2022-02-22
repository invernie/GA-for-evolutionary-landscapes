from __future__ import division

# extracts strategy frequency for the three result categories (ESS, ES and other). funtype = type of ranking (0 = linear, 1 = exponential, 2 = unspecified); fmin = min solution frequency in population before it is considered predominant in any given cycle
def go(Sel, funtype = 2, fmin = 0.80):

    import shelve, os.path
    import numpy as np

    # uncomment this and change file to .pyx to work in Cython
    #cdef int My, Ny, ay, muy, hy, rply, muty, seed, yrec, yL, ESS, ES, endy, totSeeds

    # parameter space explored in the simulations
    a_range = [0,5,10,15,20]
    Mrange = [50,100,200]
    mutrange = ['pc','pl']
    rplrange = ['det', 'fifo']
    murange = [1,3,4,7,9]
    
    # totSeeds corresponds to:
    # totSeeds = len(Mrange)*len(Nrange)*len(mutrange)*len(murange)*len(rplrange)*len(hrange)*yL
    totSeeds = 7200 # tot simulations per combination of parameters, for each value used to seed the random number generators
    yrec = 50 # n of generations at the end of the simulation in which data have been collected
    
    iESS = 32 # ESS index in list generated through itertool
    iES1 = 16 # index of the first strategy in the ES set
    iES2 = 48
    
    filepath = "D:/"                                 # path from where results are uploaded
    pathToSave = "D:/"                               # path where results of extraction are saved
    logfile = "logwritestrat.txt"                    # log of missing files (if code has run smoothly, it will be empty)
    
    if Sel == "tr" :

        hrange = [10,20,30,50]
        yL = 6                 # yL is the n of rows in the EsSMat matrix, matching the length of the longest parameter range

    elif Sel == "kt":

        krange = [2,3,5,7]
        yL = 6

    elif Sel == "rank":
        
        if funtype == 0:
            funtype = "lin"
            wrange = [55, 60, 64, 69]
        elif funtype == 1:
            funtype = "exp"
            wrange = [55, 60, 80, 89]
        else:
            raise NameError("Function type needs to be specified correctly")
            
        yL = 6


    elif Sel == "rwheel":

        wrange = [69,80,89,100]
        yL = 6
        
    else:
        raise NameError("No selection method with this name")
        

    #proportion of sims where ESS or ES reaches fmin, calculated along one parameter dimension and averaged across seeds
    EsSMat = np.zeros([yL,30], dtype = 'float64')
    #proportion of sims where ESS or ES reaches fmin in each Sel method, averaged across seed 
    seedTotMat = np.zeros([2,10], dtype = 'float64')
    #store data values individually to look at distribution ([0] ESS [1] ES [2] other)
    dtVc = np.zeros(3,dtype = 'int32')
    

    asEsSMat = np.zeros([2,10], dtype = 'float64')
    stot1 = 0
    sess1 = 0
    ses1 = 0
    r = 0
    for ay in range(5):

        print(r) # check if it's running
        r += 1
                                        
        for seed in range(10):

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                if Sel == "tr":

                                    for hy in range(4):
                                        
                                        
                                        if M == 50:
                                            Nrange = [2,5,10,12,50,1]
                                        
                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r') # opened in read-only mode
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            if ESS == 1:
                                                dtVc [0] += 1
                                            elif ES == 1:
                                                dtVc [1] += 1
                                            else:
                                                dtVc [2] += 1
                                            asEsSMat[0,seed] += ESS
                                            asEsSMat[1,seed] += ES
                                            seedTotMat[0,seed] += ESS
                                            seedTotMat[1,seed] += ES
                                            resdt.close()
                                            sess1+=ESS
                                            ses1+=ES
                                            stot1+=1
                                            
                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "kt":

                                    for ky in range(4):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 0
                                            ES = 0
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            if ESS == 1:
                                                dtVc [0] += 1
                                            elif ES== 1:
                                                dtVc [1] += 1
                                            else:
                                                dtVc [2] += 1
                                            asEsSMat[0,seed] += ESS
                                            asEsSMat[1,seed] += ES
                                            seedTotMat[0,seed] += ESS
                                            seedTotMat[1,seed] += ES
                                            resdt.close()
                                            sess1+=ESS
                                            ses1+=ES
                                            stot1+=1
                                            

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rank":

                                    for wy in range(4):

                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            if ESS == 1:
                                                dtVc [0] += 1
                                            elif ES== 1:
                                                dtVc [1] += 1
                                            else:
                                                dtVc [2] += 1
                                            asEsSMat[0,seed] += ESS
                                            asEsSMat[1,seed] += ES
                                            seedTotMat[0,seed] += ESS
                                            seedTotMat[1,seed] += ES
                                            resdt.close()
                                            sess1+=ESS
                                            ses1+=ES
                                            stot1+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rwheel":

                                    for wy in range(4):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            if ESS == 1:
                                                dtVc [0] += 1
                                            elif ES== 1:
                                                dtVc [1] += 1
                                            else:
                                                dtVc [2] += 1
                                            asEsSMat[0,seed] += ESS
                                            asEsSMat[1,seed] += ES
                                            seedTotMat[0,seed] += ESS
                                            seedTotMat[1,seed] += ES
                                            resdt.close()
                                            sess1+=ESS
                                            ses1+=ES
                                            stot1+=1
                                            
                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')
                                                              
        #scaled by tot n of sims per seed per value of the parameter under evaluation
        divisor_a = totSeeds/len(a_range)
        asEsSMat = asEsSMat/divisor_a
        EsSMat [ay,0] = sum(asEsSMat [0,:])/10
        EsSMat [ay,1] = np.std(asEsSMat [0,:])
        EsSMat [ay,2] = sum(asEsSMat [1,:])/10
        EsSMat [ay,3] = np.std(asEsSMat [1,:])
        
    #check same n of simulations is opened for each par value, 
    #same n of ESS and ES cases are reached (i.e. in our analysis we are looking at 
    #differences in the distribution) and that we are dividing for the correct n of 
    #parameter values to calculate frequencies
    print(stot1,sess1,ses1, "`divisor for a is : " + str(divisor_a))
    
    # statistics on tot convergences to each solution type for this selection method
    ## ave n of convergences to ESS across seeds 
    seedTotMat = seedTotMat/(totSeeds)
    EsSMat [0,28] = sum(seedTotMat [0,:])/10
    ## sd
    EsSMat [0,29] = np.std(seedTotMat [0,:])
    ## ave n of convergences to ES across seeds    
    EsSMat [1,28] = sum(seedTotMat [1,:])/10
    ## sd
    EsSMat [1,29] = np.std(seedTotMat [1,:])

    # tot number of convergences to each solution type for this selection method
    if funtype == "lin":
        dname = pathToSave + 'datadistr-' + Sel + 'l'
    elif funtype == "exp":
        dname = pathToSave + 'datadistr-' + Sel + 'e'
    else:
        dname = pathToSave + 'datadistr-' + Sel
    distDt = shelve.open(dname)
    distDt ['dt'] = dtVc
    distDt.close()
    

    MsEsSMat = np.zeros([2,10], dtype = 'float64')
    stot2 = 0
    sess2 = 0
    ses2 = 0
    for My in range(3):
        
        for seed in range(10):

            for ay in range(5):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                if Sel == "tr":
                                    
                                    #tr sims run without "from __future__ import division - rounding of N to smallest integer
                                    if M == 50:
                                        Nrange = [2,5,10,12,50,1]

                                    for hy in range(4):

                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            MsEsSMat[0,seed] += ESS
                                            MsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess2+=ESS
                                            ses2+=ES
                                            stot2+=1
                                            
                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "kt":

                                    for ky in range(4):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            MsEsSMat[0,seed] += ESS
                                            MsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess2+=ESS
                                            ses2+=ES
                                            stot2+=1
                                            
                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rank":

                                    for wy in range(4):
    
                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            MsEsSMat[0,seed] += ESS
                                            MsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess2+=ESS
                                            ses2+=ES
                                            stot2+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rwheel":

                                    for wy in range(4):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            MsEsSMat[0,seed] += ESS
                                            MsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess2+=ESS
                                            ses2+=ES
                                            stot2+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

        divisor_M = totSeeds/len(Mrange)
        MsEsSMat = MsEsSMat/divisor_M
        EsSMat [My,4] = sum(MsEsSMat [0,:])/10
        EsSMat [My,5] = np.std(MsEsSMat [0,:])
        EsSMat [My,6] = sum(MsEsSMat [1,:])/10
        EsSMat [My,7] = np.std(MsEsSMat [1,:])

    print(stot2,sess2,ses2, "divisor for M is : " + str(divisor_M))

    NsEsSMat = np.zeros([2,10], dtype = 'float64')
    stot3 = 0
    sess3 = 0
    ses3 = 0
    for Ny in range(6):

        for My in range(3):

            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for muty in range(2):

                    for muy in range(5):

                        for rply in range(2):

                            if Sel == "tr":
                                
                                if M == 50:
                                    Nrange = [2,5,10,12,50,1]

                                for hy in range(4):

                                    suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                    for seed in range(10):

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            NsEsSMat[0,seed] += ESS
                                            NsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess3+=ESS
                                            ses3+=ES
                                            stot3+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                            elif Sel == "kt":

                                for ky in range(4):

                                    suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                    for seed in range(10):

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            NsEsSMat[0,seed] += ESS
                                            NsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess3+=ESS
                                            ses3+=ES
                                            stot3+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                            elif Sel == "rank":

                                for wy in range(4):

                                    suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                    for seed in range(10):

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            NsEsSMat[0,seed] += ESS
                                            NsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess3+=ESS
                                            ses3+=ES
                                            stot3+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                            elif Sel == "rwheel":

                                for wy in range(4):

                                    suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                    for seed in range(10):

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            NsEsSMat[0,seed] += ESS
                                            NsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess3+=ESS
                                            ses3+=ES
                                            stot3+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

        divisor_N = totSeeds/len(Nrange)
        NsEsSMat = NsEsSMat/divisor_N
        EsSMat [Ny,8] = sum(NsEsSMat [0,:])/10
        EsSMat [Ny,9] = np.std(NsEsSMat [0,:])
        EsSMat [Ny,10] = sum(NsEsSMat [1,:])/10
        EsSMat [Ny,11] = np.std(NsEsSMat [1,:])


    print(stot3,sess3,ses3, "divisor for N is : " + str(divisor_N))
    
    mutsEsSMat = np.zeros([2,10], dtype = 'float64')
    stot4 = 0
    sess4 = 0
    ses4 = 0
    for muty in range(2):

        for seed in range(10):

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for ay in range(5):

                        for muy in range(5):

                            for rply in range(2):

                                if Sel == "tr":
                                    
                                    if M == 50:
                                        Nrange = [2,5,10,12,50,1]

                                    for hy in range(4):

                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            mutsEsSMat[0,seed] += ESS
                                            mutsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess4+=ESS
                                            ses4+=ES
                                            stot4+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "kt":

                                    for ky in range(4):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            mutsEsSMat[0,seed] += ESS
                                            mutsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess4+=ESS
                                            ses4+=ES
                                            stot4+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rank":

                                    for wy in range(4):

                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            mutsEsSMat[0,seed] += ESS
                                            mutsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess4+=ESS
                                            ses4+=ES
                                            stot4+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rwheel":

                                    for wy in range(4):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            mutsEsSMat[0,seed] += ESS
                                            mutsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess4+=ESS
                                            ses4+=ES
                                            stot4+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

        divisor_mut = totSeeds/len(mutrange)
        mutsEsSMat = mutsEsSMat/divisor_mut
        EsSMat [muty,12] = sum(mutsEsSMat [0,:])/10
        EsSMat [muty,13] = np.std(mutsEsSMat [0,:])
        EsSMat [muty,14] = sum(mutsEsSMat [1,:])/10
        EsSMat [muty,15] = np.std(mutsEsSMat [1,:])
        
    print(stot4,sess4,ses4, "divisor for mut is " + str(divisor_mut))

    musEsSMat = np.zeros([2,10], dtype = 'float64')
    stot5 = 0
    sess5 = 0
    ses5 = 0
    for muy in range(5):
        
        for seed in range(10):

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for ay in range(5):

                            for rply in range(2):

                                if Sel == "tr":
                                    
                                    if M == 50:
                                        Nrange = [2,5,10,12,50,1]

                                    for hy in range(4):

                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            musEsSMat[0,seed] += ESS
                                            musEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess5+=ESS
                                            ses5+=ES
                                            stot5+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "kt":

                                    for ky in range(4):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            musEsSMat[0,seed] += ESS
                                            musEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess5+=ESS
                                            ses5+=ES
                                            stot5+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rank":

                                    for wy in range(4):

                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            musEsSMat[0,seed] += ESS
                                            musEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess5+=ESS
                                            ses5+=ES
                                            stot5+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rwheel":

                                    for wy in range(4):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            musEsSMat[0,seed] += ESS
                                            musEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess5+=ESS
                                            ses5+=ES
                                            stot5+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

        divisor_mu = totSeeds/len(murange)
        musEsSMat = musEsSMat/divisor_mu
        EsSMat [muy,16] = sum(musEsSMat [0,:])/10
        EsSMat [muy,17] = np.std(musEsSMat [0,:])
        EsSMat [muy,18] = sum(musEsSMat [1,:])/10
        EsSMat [muy,19] = np.std(musEsSMat [1,:])
        
    print(stot5,sess5,ses5, "divisor for mu is " + str(divisor_mu))

    rplsEsSMat = np.zeros([2,10], dtype = 'float64')
    stot6 = 0
    sess6 = 0
    ses6 = 0
    for rply in range(2):
        
        for seed in range(10):

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for ay in range(5):

                                if Sel == "tr":
                                    
                                    if M == 50:
                                        Nrange = [2,5,10,12,50,1]

                                    for hy in range(4):

                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            rplsEsSMat[0,seed] += ESS
                                            rplsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess6+=ESS
                                            ses6+=ES
                                            stot6+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "kt":

                                    for ky in range(4):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            rplsEsSMat[0,seed] += ESS
                                            rplsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess6+=ESS
                                            ses6+=ES
                                            stot6+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rank":

                                    for wy in range(4):

                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            rplsEsSMat[0,seed] += ESS
                                            rplsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess6+=ESS
                                            ses6+=ES
                                            stot6+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                elif Sel == "rwheel":

                                    for wy in range(4):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            rplsEsSMat[0,seed] += ESS
                                            rplsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess6+=ESS
                                            ses6+=ES
                                            stot6+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')



        divisor_rpl = totSeeds/len(rplrange)
        rplsEsSMat = rplsEsSMat/divisor_rpl
        EsSMat [rply,20] = sum(rplsEsSMat [0,:])/10
        EsSMat [rply,21] = np.std(rplsEsSMat [0,:])
        EsSMat [rply,22] = sum(rplsEsSMat [1,:])/10
        EsSMat [rply,23] = np.std(rplsEsSMat [1,:])
        
    print(stot6,sess6,ses6, "divisor for rpl is " + str(divisor_rpl))

    selsEsSMat = np.zeros([2,10], dtype = 'float64')
    stot7 = 0
    sess7 = 0
    ses7 = 0
    if Sel == "tr":

        for hy in range(4):
            
            for seed in range(10):

                for My in range(3):

                    M = Mrange[My]
                    if M == 50:
                        Nrange = [2,5,10,12,50,1]
                    else:
                        Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    for ay in range(5):

                                        suffix = "tr/tr-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            selsEsSMat[0,seed] += ESS
                                            selsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess7+=ESS
                                            ses7+=ES
                                            stot7+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')
                          
            divisor = totSeeds/len(hrange)
            selsEsSMat = selsEsSMat/divisor
            EsSMat [hy,24] = sum(selsEsSMat [0,:])/10
            EsSMat [hy,25] = np.std(selsEsSMat [0,:])
            EsSMat [hy,26] = sum(selsEsSMat [1,:])/10
            EsSMat [hy,27] = np.std(selsEsSMat [1,:])

    elif Sel == "kt":
        
        for ky in range(4):
            
            for seed in range(10):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    for ay in range(5):

                                        suffix = "kt/kt-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            selsEsSMat[0,seed] += ESS
                                            selsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess7+=ESS
                                            ses7+=ES
                                            stot7+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

            divisor = totSeeds/len(krange)
            selsEsSMat = selsEsSMat/divisor
            EsSMat [ky,24] = sum(selsEsSMat [0,:])/10
            EsSMat [ky,25] = np.std(selsEsSMat [0,:])
            EsSMat [ky,26] = sum(selsEsSMat [1,:])/10
            EsSMat [ky,27] = np.std(selsEsSMat [1,:])

    elif Sel == "rank":

        for wy in range(4):
            
            for seed in range(10):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    for ay in range(5):

                                        suffix = "rank/rank-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-" + funtype + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            selsEsSMat[0,seed] += ESS
                                            selsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess7+=ESS
                                            ses7+=ES
                                            stot7+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

            divisor = totSeeds/len(wrange)
            selsEsSMat = selsEsSMat/divisor
            EsSMat [wy,24] = sum(selsEsSMat [0,:])/10
            EsSMat [wy,25] = np.std(selsEsSMat [0,:])
            EsSMat [wy,26] = sum(selsEsSMat [1,:])/10
            EsSMat [wy,27] = np.std(selsEsSMat [1,:])

    elif Sel == "rwheel":
        
        for wy in range(4):
            
            for seed in range(10):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    for ay in range(5):

                                        suffix = "rw/rw-a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])

                                        filename = filepath + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):
                                            resdt = shelve.open(filename, flag = 'r')
                                            freqList = resdt['freqList']
                                            #are the ESS or the ES the predominant (>fmin) strategy in the population at each one of the final recorded time points?
                                            ESS = 1
                                            ES = 1
                                            for endy in range(yrec):
                                                if ESS>0 or ES>0:
                                                    if freqList [endy] [iESS] >= fmin:
                                                        ESS = 1
                                                    else:
                                                        ESS = 0
                                                    if freqList [endy] [iES1] + freqList [endy] [iES2] >= fmin:
                                                        ES = 1
                                                    else:
                                                        ES = 0
                                                else:
                                                    break
                                            selsEsSMat[0,seed] += ESS
                                            selsEsSMat[1,seed] += ES
                                            resdt.close()
                                            sess7+=ESS
                                            ses7+=ES
                                            stot7+=1

                                        else:
                                            with open(logfile, 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

            divisor = totSeeds/len(wrange)
            selsEsSMat = selsEsSMat/divisor
            EsSMat [wy,24] = sum(selsEsSMat [0,:])/10
            EsSMat [wy,25] = np.std(selsEsSMat [0,:])
            EsSMat [wy,26] = sum(selsEsSMat [1,:])/10
            EsSMat [wy,27] = np.std(selsEsSMat [1,:])
            
    print(stot7,sess7,ses7, ", divisor for sel par is " + str(divisor))
    
            
    
    # save extracted statistics to csv file
    if Sel == "rank":
        if funtype == "lin":
            np.savetxt(pathToSave + "summaries/SPS" + Sel + "l-ESS-ES.csv", EsSMat, delimiter = ",", header = "a-ESS, a-ESS-sd, a-ES, a-ES-sd, M-ESS, M-ESS-sd, M-ES, M-ES-sd, N-ESS, N-ESS-sd, N-ES, N-ES-sd, mut-ESS, mut-ESS-sd,mut-ES,mut-ES-sd,mu-ESS,mu-ESS-sd,mu-ES,mu-ES-sd,rpl-ESS,rpl-ESS-sd,rpl-ES,rpl-ES-sd,o-ESS,o-ESS-sd,o-ES,o-ES-sd,ave,ave-sd")
        elif funtype == "exp":
            np.savetxt(pathToSave + "summaries/SPS" + Sel + "e-ESS-ES.csv", EsSMat, delimiter = ",", header = "a-ESS, a-ESS-sd, a-ES, a-ES-sd, M-ESS, M-ESS-sd, M-ES, M-ES-sd, N-ESS, N-ESS-sd, N-ES, N-ES-sd, mut-ESS, mut-ESS-sd, mut-ES, mut-ES-sd, mu-ESS, mu-ESS-sd,mu-ES, mu-ES-sd, rpl-ESS, rpl-ESS-sd, rpl-ES, rpl-ES-sd,c-ESS, c-ESS-sd,c-ES, c-ES-sd,ave,ave-sd")
    elif Sel == "kt":
        np.savetxt(pathToSave + "summaries/SPS" + Sel + "-ESS-ES.csv", EsSMat, delimiter = ",", header = "a-ESS, a-ESS-sd, a-ES, a-ES-sd, M-ESS, M-ESS-sd, M-ES, M-ES-sd, N-ESS, N-ESS-sd, N-ES, N-ES-sd, mut-ESS, mut-ESS-sd, mut-ES, mut-ES-sd, mu-ESS, mu-ESS-sd,mu-ES, mu-ES-sd, rpl-ESS, rpl-ESS-sd, rpl-ES, rpl-ES-sd,k-ESS, k-ESS-sd,k-ES, k-ES-sd,ave,ave-sd")
    elif Sel == "tr":
        np.savetxt(pathToSave + "summaries/SPS" + Sel + "-ESS-ES.csv", EsSMat, delimiter = ",", header = "a-ESS, a-ESS-sd, a-ES, a-ES-sd, M-ESS, M-ESS-sd, M-ES, M-ES-sd, N-ESS, N-ESS-sd, N-ES, N-ES-sd, mut-ESS, mut-ESS-sd, mut-ES, mut-ES-sd, mu-ESS, mu-ESS-sd,mu-ES, mu-ES-sd, rpl-ESS, rpl-ESS-sd, rpl-ES, rpl-ES-sd,h-ESS, h-ESS-sd,h-ES, h-ES-sd,ave,ave-sd")
    elif Sel == "rwheel":
        np.savetxt(pathToSave + "summaries/SPS" + Sel + "-ESS-ES.csv", EsSMat, delimiter = ",", header = "a-ESS, a-ESS-sd, a-ES, a-ES-sd, M-ESS, M-ESS-sd, M-ES, M-ES-sd, N-ESS, N-ESS-sd, N-ES, N-ES-sd, mut-ESS, mut-ESS-sd, mut-ES, mut-ES-sd, mu-ESS, mu-ESS-sd,mu-ES, mu-ES-sd, rpl-ESS, rpl-ESS-sd, rpl-ES, rpl-ES-sd,w-ESS, w-ESS-sd,w-ES, w-ES-sd,ave,ave-sd")
