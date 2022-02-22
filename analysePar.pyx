from __future__ import division

#The next five functions run the simulation set for each Selection method
def tr(a):

    import SPS_truncation

    #variables:
    #rf= assignment function (0 = linear, 1 = exponential); mut (0 = per locus, 1 = per chromosome); rpl (0 = deterministic, 1 = FIFO); sel (0 = truncation, 1 = k-tournament, 2 = ranking, 3 = roulette- wheel)
    cdef int seed, mut, rpl, M, N
    cdef float h, mu

    Mrange = [50,100,200]
    hrange = [0.10,0.20,0.30,0.50]
    murange = [0.001,0.003,0.005,0.007,0.01]


    for M in Mrange:

        Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

        for N in Nrange:

            for mut in range(2):

                for mu in murange:

                    for rpl in range(2):

                        for h in hrange:

                            #replicates seeded with different intialisation values of the random number generator (X10)
                            for seed in range(10):

                                try:

                                    SPS_truncation.run(seed, mut, rpl, M, N, a, h, mu)


                                except Exception as e:
                                    with open("/home/edith/Documents/python_srpt/tr-logrunres.txt", "a+") as lf:
                                        lf.append("a" + str(int(round(a*100))) + "M" + str(M) + "-N" + str(N) + "-tr" + str(int(round(M*h))) + "-mut" + str(mut) + "-mu" + str(int(round(mu*1000))) + "-rpl" + str(rpl) + "-s" + str(seed) + ", " + str(e))


def kt(a):

    import SPS_ktour

    #variables:
    #rf= assignment function (0 = linear, 1 = exponential); mut (0 = per locus, 1 = per chromosome); rpl (0 = deterministic, 1 = FIFO); sel (0 = truncation, 1 = k-tournament, 2 = ranking, 3 = roulette- wheel)
    cdef int seed, mut, rpl, M, N, K
    cdef float mu

    Mrange = [50,100,200]
    murange = [0.001,0.003,0.005,0.007,0.01]
    Krange = [2,3,5,7]

    for M in Mrange:

        Nrange = [int(round(M/20)),M/10,M/5,int(round(M/4)),M,1]

        for N in Nrange:

            for mut in range(2):

                for mu in murange:

                    for rpl in range(2):

                        for K in Krange:

                            for seed in range(10):

                                try:

                                    SPS_ktour.run(seed, mut, rpl, M, N, a, mu, K)


                                except Exception as e:
                                    with open("/home/edith/Documents/python_srpt/kt-logrunres.txt", "a+") as lf:
                                        lf.append("a" + str(int(round(a*100))) + "M" + str(M) + "-N" + str(N) + "-K" + str(K) + "-mut" + str(mut) + "-mu" + str(int(round(mu*1000))) + "-rpl" + str(rpl) + "-s" + str(seed) + ", " + str(e))


def rw(a):

    import SPS_rwheel

    #variables:
    #rf= assignment function (0 = linear, 1 = exponential); mut (0 = per locus, 1 = per chromosome); rpl (0 = deterministic, 1 = FIFO); sel (0 = truncation, 1 = k-tournament, 2 = ranking, 3 = roulette- wheel)
    cdef int seed, mut, rpl, M, N
    cdef float w, mu

    Mrange = [50,100,200]
    murange = [0.001,0.003,0.005,0.007,0.01]
    wrange = [0.70,0.80,0.90,1]

    for M in Mrange:

        Nrange = [int(round(M/20)),M/10,M/5,int(round(M/4)),M,1]

        for N in Nrange:

            for mut in range(2):

                for mu in murange:

                    for rpl in range(2):

                        for w in wrange:

                            for seed in range(10):

                                try:

                                    SPS_rwheel.run(seed, mut, rpl, M, N, a, mu, w)


                                except Exception as e:
                                    with open("/home/edith/Documents/python_srpt/rw-logrunres.txt", "a+") as lf:
                                        lf.append("a" + str(int(round(a*100))) + "M" + str(M) + "-N" + str(N) + "-w" + str(int(round(w*100))) + "-mut" + str(mut) + "-mu" + str(int(round(mu*1000))) + "-rpl" + str(rpl) + "-s" + str(seed) + ", " + str(e))


def ranke(a):

    import SPS_rank

    #variables:
    #rf= assignment function (0 = linear, 1 = exponential); mut (0 = per locus, 1 = per chromosome); rpl (0 = deterministic, 1 = FIFO); sel (0 = truncation, 1 = k-tournament, 2 = ranking, 3 = roulette- wheel)
    cdef int seed, mut, rpl, M, N
    cdef float c, mu

    Mrange = [50,100,200]
    murange = [0.001,0.003,0.005,0.007,0.01]
    crange = [0.55, 0.60, 0.80, 0.90]

    for M in Mrange:

        Nrange = [int(round(M/20)),M/10,M/5,int(round(M/4)),M,1]

        for N in Nrange:

            for mut in range(2):

                for mu in murange:

                    for rpl in range(2):

                        for c in crange:

                             for seed in range(10):

                                try:

                                    SPS_rank.run(seed, mut, rpl, M, N, a, mu, 1, c)


                                except Exception as e:
                                    with open("/home/edith/Documents/python_srpt/ranke-logrunres.txt", "a+") as lf:
                                        lf.append("a" + str(int(round(a*100))) + "M" + str(M) + "-N" + str(N) + "-c" + str(int(round(c*100))) + "-mut" + str(mut) + "-mu" + str(int(round(mu*1000))) + "-rpl" + str(rpl) + "-s" + str(seed) + ", " + str(e))


def rankl(a):

    import SPS_rank

    #variables:
    #rf= assignment function (0 = linear, 1 = exponential); mut (0 = per locus, 1 = per chromosome); rpl (0 = deterministic, 1 = FIFO); sel (0 = truncation, 1 = k-tournament, 2 = ranking, 3 = roulette- wheel)
    cdef int seed, mut, rpl, M, N
    cdef float O, mu

    Mrange = [50,100,200]
    murange = [0.001,0.003,0.005,0.007,0.01]
    orange = [0.55, 0.60, 0.65, 0.70]

    for M in Mrange:

        Nrange = [int(round(M/20)),M/10,M/5,int(round(M/4)),M,1]

        for N in Nrange:

            for mut in range(2):

                for mu in murange:

                    for rpl in range(2):

                        for O in orange:

                            for seed in range(10):

                                try:

                                    SPS_rank.run(seed, mut, rpl, M, N, a, mu, 0, O)


                                except Exception as e:
                                    with open("/home/edith/Documents/python_srpt/rankl-logrunres.txt", "a+") as lf:
                                        lf.append("a" + str(int(round(a*100))) + "M" + str(M) + "-N" + str(N) + "-O" + str(int(round(O*100))) + "-mut" + str(mut) + "-mu" + str(int(round(mu*1000))) + "-rpl" + str(rpl) + "-s" + str(seed) + ", " + str(e))


#extracts 1. top 10 fastest parameter combinations per sel method; and 2. mean and SD of computation time along parameter sweep per parameter per sel method
def calcTime(Sel):

    import shelve, os.path
    import numpy as np

    cdef int My, Ny, ay, muy, hy, rply, muty, seed, yL, point, s

    a_range = [0,5,10,15,20]
    Mrange = [50,100,200]
    mutrange = ['pc','pl']
    rplrange = ['det', 'fifo']
    murange = [1,3,4,7,9]


    if Sel == "tr" :

        hrange = [10,20,30,50]
        yL = 6

    elif Sel == "kt":

        krange = [2,3,5,7]
        yL = 6

    elif Sel == "rw":

        wrange = [69,80,89,100]
        yL = 6

    elif Sel == "ranke":
        crange = [55, 60, 80, 89]
        yL = 6

    elif Sel == "rankl":
        orange = [55, 60, 64, 69]
        yL = 6

    #len of timesMat cols are identical for all parameters. Each will need subsetting at different indices.
    timesMat = np.zeros([yL,14], dtype = 'float16')
    #fastest parameter combinations per Sel method - extracted only once at first loop through parameters
    #1: time, 2: SD across seed, 3: combination
    fastMeth = np.ndarray(10, dtype = 'float16, float16, <U50')
    fastMeth.dtype.names = ('t', 'sd', 'combo')
    point = 0

    if Sel == "tr":

        for ay in range(5):

            aTime = list()

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    tList = list()
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            tList.append(dt['totT'])
                                            s += 1
                                            dt.close()

                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    totT = sum(tList)/s
                                    seedSD = np.std(tList)
                                    aTime.append(totT)


                                    # check for any aberrant time recordings
                                    if totT < 0:

                                        with open('logtime.txt', 'a+') as lt:
                                            lt.write(suffix + '\n')

                                    #find top 10 times
                                    if point < 10: #just record first 10 values

                                        fastMeth ['t'] [point] = totT
                                        fastMeth ['sd'] [point] = seedSD
                                        fastMeth ['combo'] [point] = suffix

                                    elif totT < max(fastMeth ['t']): #then substitute with combinations quicker than any of the first 10

                                        maxI = np.argmax(fastMeth ['t'])
                                        fastMeth ['t'] [maxI] = totT
                                        fastMeth ['sd'] [maxI] = seedSD
                                        fastMeth ['combo'] [maxI] = suffix

                                    point += 1

            timesMat [ay,0] = sum(aTime)/len(aTime)
            timesMat [ay,1] = np.std(aTime)

        for My in range(3):

            MTime = list()
            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    MTime.append(totT/s)

            timesMat [My,2] = sum(MTime)/len(MTime)
            timesMat [My,3] = np.std(MTime)

        for Ny in range(6):

            NTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    NTime.append(totT/s)

            timesMat [Ny,4] = sum(NTime)/len(NTime)
            timesMat [Ny,5] = np.std(NTime)

        for muy in range(5):

            muTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for Ny in range(6):

                            for rply in range(2):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    muTime.append(totT/s)

            timesMat [muy,6] = sum(muTime)/len(muTime)
            timesMat [muy,7] = np.std(muTime)

        for muty in range(2):

            mutTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muy in range(5):

                            for rply in range(2):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    mutTime.append(totT/s)

            timesMat [muty,8] = sum(mutTime)/len(mutTime)
            timesMat [muty,9] = np.std(mutTime)

        for rply in range(2):

            rplTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for hy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    rplTime.append(totT/s)

            timesMat [rply,10] = sum(rplTime)/len(rplTime)
            timesMat [rply,11] = np.std(rplTime)

        for hy in range(4):

            hTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-tr" + str(hrange[hy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/tr-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    hTime.append(totT/s)

            timesMat [hy,12] = sum(hTime)/len(hTime)
            timesMat [hy,13] = np.std(hTime)


            np.savetxt("/home/edith/Documents/GA/results/times/SPS-tr-times.csv", timesMat, delimiter = ",", header = "a,a-sd,M,M-sd,N,N-sd,mu,mu-sd,mut,mut-sd,rpl,rpl-sd,h,h-sd")
            np.savetxt("/home/edith/Documents/GA/results/times/SPS-tr-10best.csv", fastMeth, delimiter = ",", fmt = ['%.6f','%.6f', '%50s'])


    if Sel == "kt":

        for ay in range(5):

            aTime = list()

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    tList = list()
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            tList.append(dt['totT'])
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                    totT = sum(tList)/s
                                    seedSD = np.std(tList)
                                    aTime.append(totT)


                                    # check for any aberrant time recordings
                                    if totT < 0:

                                        with open('logtime.txt', 'a+') as lt:
                                            lt.write(filename + '\n')

                                    #find top 10 times
                                    if point < 10: #just record first 10 values

                                        fastMeth ['t'] [point] = totT
                                        fastMeth ['sd'] [point] = seedSD
                                        fastMeth ['combo'] [point] = suffix
                                        print fastMeth ['combo'] [point]

                                    elif totT < max(fastMeth ['t']): #then substitute with combinations quicker than any of the first 10

                                        maxI = np.argmax(fastMeth ['t'])
                                        fastMeth ['t'] [maxI] = totT
                                        fastMeth ['sd'] [maxI] = seedSD
                                        fastMeth ['combo'] [maxI] = suffix

                                    point += 1

            timesMat [ay,0] = sum(aTime)/len(aTime)
            timesMat [ay,1] = np.std(aTime)

        for My in range(3):

            MTime = list()
            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    MTime.append(totT/s)

            timesMat [My,2] = sum(MTime)/len(MTime)
            timesMat [My,3] = np.std(MTime)

        for Ny in range(6):

            NTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    NTime.append(totT/s)

            timesMat [Ny,4] = sum(NTime)/len(NTime)
            timesMat [Ny,5] = np.std(NTime)

        for muy in range(5):

            muTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for Ny in range(6):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    muTime.append(totT/s)

            timesMat [muy,6] = sum(muTime)/len(muTime)
            timesMat [muy,7] = np.std(muTime)

        for muty in range(2):

            mutTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    mutTime.append(totT/s)

            timesMat [muty,8] = sum(mutTime)/len(mutTime)
            timesMat [muty,9] = np.std(mutTime)

        for rply in range(2):

            rplTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    rplTime.append(totT/s)

            timesMat [rply,10] = sum(rplTime)/len(rplTime)
            timesMat [rply,11] = np.std(rplTime)

        for ky in range(4):

            kTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-k" + str(krange[ky]) + "-alp100-"+ str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/kt/kt-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    kTime.append(totT/s)

            timesMat [ky,12] = sum(kTime)/len(kTime)
            timesMat [ky,13] = np.std(kTime)


            np.savetxt("/home/edith/Documents/GA/results/times/SPS-kt-times.csv", timesMat, delimiter = ",", header = "a,a-sd,M,M-sd,N,N-sd,mu,mu-sd,mut,mut-sd,rpl,rpl-sd,k,k-sd")
            np.savetxt("/home/edith/Documents/GA/results/times/SPS-kt-10best.csv", fastMeth, delimiter = ",", fmt = ['%.6f','%.6f', '%50s'])

    if Sel == "rw":

        for ay in range(5):

            aTime = list()

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for wy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    tList = list()
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            tList.append(dt['totT'])
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                    totT = sum(tList)/s
                                    seedSD = np.std(tList)
                                    aTime.append(totT)


                                    # check for any aberrant time recordings
                                    if totT < 0:

                                        with open('logtime.txt', 'a+') as lt:
                                            lt.write(filename + '\n')

                                    #find top 10 times
                                    if point < 10: #just record first 10 values

                                        fastMeth ['t'] [point] = totT
                                        fastMeth ['sd'] [point] = seedSD
                                        fastMeth ['combo'] [point] = suffix
                                        print fastMeth ['combo'] [point]

                                    elif totT < max(fastMeth ['t']): #then substitute with combinations quicker than any of the first 10

                                        maxI = np.argmax(fastMeth ['t'])
                                        fastMeth ['t'] [maxI] = totT
                                        fastMeth ['sd'] [maxI] = seedSD
                                        fastMeth ['combo'] [maxI] = suffix

                                    point += 1

            timesMat [ay,0] = sum(aTime)/len(aTime)
            timesMat [ay,1] = np.std(aTime)

        for My in range(3):

            MTime = list()
            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for wy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    MTime.append(totT/s)

            timesMat [My,2] = sum(MTime)/len(MTime)
            timesMat [My,3] = np.std(MTime)

        for Ny in range(6):

            NTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for wy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    NTime.append(totT/s)

            timesMat [Ny,4] = sum(NTime)/len(NTime)
            timesMat [Ny,5] = np.std(NTime)

        for muy in range(5):

            muTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for Ny in range(6):

                            for rply in range(2):

                                for wy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    muTime.append(totT/s)

            timesMat [muy,6] = sum(muTime)/len(muTime)
            timesMat [muy,7] = np.std(muTime)

        for muty in range(2):

            mutTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    mutTime.append(totT/s)

            timesMat [muty,8] = sum(mutTime)/len(mutTime)
            timesMat [muty,9] = np.std(mutTime)

        for rply in range(2):

            rplTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for wy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    rplTime.append(totT/s)

            timesMat [rply,10] = sum(rplTime)/len(rplTime)
            timesMat [rply,11] = np.std(rplTime)

        for wy in range(4):

            wTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-w" + str(wrange[wy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rw/rw-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    wTime.append(totT/s)

            timesMat [wy,12] = sum(wTime)/len(wTime)
            timesMat [wy,13] = np.std(wTime)


            np.savetxt("/home/edith/Documents/GA/results/times/SPS-rw-times.csv", timesMat, delimiter = ",", header = "a,a-sd,M,M-sd,N,N-sd,mu,mu-sd,mut,mut-sd,rpl,rpl-sd,w,w-sd")
            np.savetxt("/home/edith/Documents/GA/results/times/SPS-rw-10best.csv", fastMeth, delimiter = ",", fmt = ['%.6f','%.6f', '%50s'])

    if Sel == "ranke":

        for ay in range(5):

            aTime = list()

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for cy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    tList = list()
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            tList.append(dt['totT'])
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                    totT = sum(tList)/s
                                    seedSD = np.std(tList)
                                    aTime.append(totT)


                                    # check for any aberrant time recordings
                                    if totT < 0:

                                        with open('logtime.txt', 'a+') as lt:
                                            lt.write(filename + '\n')

                                    #find top 10 times
                                    if point < 10: #just record first 10 values

                                        fastMeth ['t'] [point] = totT
                                        fastMeth ['sd'] [point] = seedSD
                                        fastMeth ['combo'] [point] = suffix
                                        print fastMeth ['combo'] [point]

                                    elif totT < max(fastMeth ['t']): #then substitute with combinations quicker than any of the first 10

                                        maxI = np.argmax(fastMeth ['t'])
                                        fastMeth ['t'] [maxI] = totT
                                        fastMeth ['sd'] [maxI] = seedSD
                                        fastMeth ['combo'] [maxI] = suffix

                                    point += 1

            timesMat [ay,0] = sum(aTime)/len(aTime)
            timesMat [ay,1] = np.std(aTime)

        for My in range(3):

            MTime = list()
            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for cy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    MTime.append(totT/s)

            timesMat [My,2] = sum(MTime)/len(MTime)
            timesMat [My,3] = np.std(MTime)

        for Ny in range(6):

            NTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for cy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    NTime.append(totT/s)

            timesMat [Ny,4] = sum(NTime)/len(NTime)
            timesMat [Ny,5] = np.std(NTime)

        for muy in range(5):

            muTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for Ny in range(6):

                            for rply in range(2):

                                for cy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    muTime.append(totT/s)

            timesMat [muy,6] = sum(muTime)/len(muTime)
            timesMat [muy,7] = np.std(muTime)

        for muty in range(2):

            mutTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muy in range(5):

                            for rply in range(2):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    mutTime.append(totT/s)

            timesMat [muty,8] = sum(mutTime)/len(mutTime)
            timesMat [muty,9] = np.std(mutTime)

        for rply in range(2):

            rplTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for ky in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    rplTime.append(totT/s)

            timesMat [rply,10] = sum(rplTime)/len(rplTime)
            timesMat [rply,11] = np.std(rplTime)

        for cy in range(4):

            cTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-exp" + str(crange[cy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    cTime.append(totT/s)

            timesMat [cy,12] = sum(cTime)/len(cTime)
            timesMat [cy,13] = np.std(cTime)


            np.savetxt("/home/edith/Documents/GA/results/times/SPS-ranke-times.csv", timesMat, delimiter = ",", header = "a,a-sd,M,M-sd,N,N-sd,mu,mu-sd,mut,mut-sd,rpl,rpl-sd,c,c-sd")
            np.savetxt("/home/edith/Documents/GA/results/times/SPS-ranke-10best.csv", fastMeth, delimiter = ",", fmt = ['%.6f','%.6f', '%50s'])

    if Sel == "rankl":

        for ay in range(5):

            aTime = list()

            for My in range(3):

                M = Mrange[My]
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    tList = list()
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            tList.append(dt['totT'])
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')

                                    totT = sum(tList)/s
                                    seedSD = np.std(tList)
                                    aTime.append(totT)


                                    # check for any aberrant time recordings
                                    if totT < 0:

                                        with open('logtime.txt', 'a+') as lt:
                                            lt.write(filename + '\n')

                                    #find top 10 times
                                    if point < 10: #just record first 10 values

                                        fastMeth ['t'] [point] = totT
                                        fastMeth ['sd'] [point] = seedSD
                                        fastMeth ['combo'] [point] = suffix
                                        print fastMeth ['combo'] [point]

                                    elif totT < max(fastMeth ['t']): #then substitute with combinations quicker than any of the first 10

                                        maxI = np.argmax(fastMeth ['t'])
                                        fastMeth ['t'] [maxI] = totT
                                        fastMeth ['sd'] [maxI] = seedSD
                                        fastMeth ['combo'] [maxI] = suffix

                                    point += 1

            timesMat [ay,0] = sum(aTime)/len(aTime)
            timesMat [ay,1] = np.std(aTime)

        for My in range(3):

            MTime = list()
            M = Mrange[My]
            Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

            for ay in range(5):

                for Ny in range(6):

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    MTime.append(totT/s)

            timesMat [My,2] = sum(MTime)/len(MTime)
            timesMat [My,3] = np.std(MTime)

        for Ny in range(6):

            NTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for muy in range(5):

                            for rply in range(2):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    NTime.append(totT/s)

            timesMat [Ny,4] = sum(NTime)/len(NTime)
            timesMat [Ny,5] = np.std(NTime)

        for muy in range(5):

            muTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for muty in range(2):

                        for Ny in range(6):

                            for rply in range(2):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    muTime.append(totT/s)

            timesMat [muy,6] = sum(muTime)/len(muTime)
            timesMat [muy,7] = np.std(muTime)

        for muty in range(2):

            mutTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muy in range(5):

                            for rply in range(2):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    mutTime.append(totT/s)

            timesMat [muty,8] = sum(mutTime)/len(mutTime)
            timesMat [muty,9] = np.std(mutTime)

        for rply in range(2):

            rplTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for oy in range(4):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    rplTime.append(totT/s)

            timesMat [rply,10] = sum(rplTime)/len(rplTime)
            timesMat [rply,11] = np.std(rplTime)

        for oy in range(4):

            oTime = list()

            for ay in range(5):

                for My in range(3):

                    M = Mrange[My]
                    Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]

                    for Ny in range(6):

                        for muty in range(2):

                            for muy in range(5):

                                for rply in range(2):

                                    suffix = "a" + str(a_range[ay]) + "M" + str(M) + "-N" + str(Nrange[Ny]) + "-lin" + str(orange[oy]) + "-" + str(mutrange[muty]) + str(murange[muy]) + "-" + str(rplrange[rply])
                                    totT = 0
                                    s = 0

                                    for seed in range(10):

                                        filename = "/home/edith/Documents/GA/results/rank/rank-" + suffix + "-" + str(seed)

                                        if os.path.isfile(filename):

                                            dt = shelve.open(filename)
                                            totT += dt['totT']
                                            s += 1


                                        else:
                                            with open('logwritetime.txt', 'a+') as l:

                                                l.write(filename + " non-existent" + '\n')

                                    oTime.append(totT/s)

            timesMat [oy,12] = sum(oTime)/len(oTime)
            timesMat [oy,13] = np.std(oTime)


            np.savetxt("/home/edith/Documents/GA/results/times/SPS-rankl-times.csv", timesMat, delimiter = ",", header = "a,a-sd,M,M-sd,N,N-sd,mu,mu-sd,mut,mut-sd,rpl,rpl-sd,o,o-sd")
            np.savetxt("/home/edith/Documents/GA/results/times/SPS-rankl-10best.csv", fastMeth, delimiter = ",", fmt = ['%.6f','%.6f', '%50s'])


#extracts 1. average computation time per sel method; 2. average online performance and 3. average offline performance across whole sim length per sel method
def summarise():

    np.seterr(invalid='raise')
    
    filepath = "/media/edith/Elements/GA/"

    #sim parameters
    Selrange = ["tr","kt","rw","rank"]
    #Selrange = ["rank"]
    a_range = [0,5,10,15,20]
    #a_range = [0]
    Mrange = [50,100,200]
    #Mrange = [50]
    mutrange = ['pc','pl']
    #mutrange = ['pc']
    rplrange = ['det', 'fifo']
    #rplrange = ["det"]
    murange = [1,3,4,7,9]
    #murange = [1]
    yTot = 500
    
    #useful func refs
    isfile = os.path.isfile
    opensf = shelve.open
    def calcOnline(aveP):
        return sum(aveP)/yTot
    def calcOffline(best50):
		return(sum(best50)/yTot)
    
    trList = list()
    ktList = list()
    rankeList = list()
    ranklList = list()
    rwList = list()
    rlonList = list()
    rloffList = list()
    ranklAppend = ranklList.append
    rlonAppend = rlonList.append
    rloffAppend = rloffList.append
    
    
    tSummary = np.zeros([2,5], "float64")
    onlineperf = np.zeros([5], "float64")
    offlineperf = np.zeros([2,5], "float64")
    Sel2 = 0
    
    for Sel in Selrange:
        
        onList = list()
        offList = list()
        onAppend = onList.append
        offAppend = offList.append
        if Sel == "tr":
            selAppend = trList.append
            selpr = Sel
            sparrange = [10,20,30,50]
            alpha = ""
        elif Sel == "kt":
            selAppend = ktList.append
            selpr = "k"
            sparrange = [2,3,5,7]
            alpha = "-alp100"
        #start by running exp ranking
        elif Sel == "rank":
            selAppend = rankeList.append
            selpr = "exp"
            sparrange = [55, 60, 80, 89]
            alpha = ""
        elif Sel =="rw":
            selAppend = rwList.append
            selpr = "w"
            sparrange = [69,80,89,100]
            alpha = ""
    
        for a in a_range:
        
            for M in Mrange:
            
                Nrange = [int(round(M/20)),int(M/10),int(M/5),int(round(M/4)),M,1]
                #set of sims with truncation selection used default division method for Python 2 - integer part of the value only taken
                if Sel == "tr" and M == 50:
                    Nrange = [2,5,10,12,50,1]
                  
                for N in Nrange:
              
                    for muty in mutrange:
                   
                        for muy in murange:
                      
                            for rply in rplrange:
                                    
                                for p in sparrange:
                          
                                    prefix = "%s%s/%s-a%sM%s-N%s-%s%s%s-%s%s-%s" %(filepath,Sel,Sel,a,M,N,selpr,p,alpha,muty,muy,rply)
        
                                    for seed in xrange(10):
                                    
                                        filename = "%s-%s" % (prefix,str(seed))
                                        if isfile(filename):
                                            
                                            dt = opensf(filename)
                                            selAppend(dt['totT'])
                                            onAppend(calcOnline(dt["aveFit"][0]))
                                            offAppend(calcOffline(dt["aveBest"]))
                                            dt.close()

                                        else:
                                            with open('logwritesummaries.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')
                                                
        
                                #run inner lop for second (linear) ranking method
                                if Sel == "rank":
                                    selpr = "lin"
                                    sparrange = [55, 60, 64, 69]
                                    Sel2 = "rankl"
                                    
                                    for p in sparrange:
                                        prefix = "%s%s/%s-a%sM%s-N%s-%s%s-%s%s-%s" %(filepath,Sel,Sel,a,M,N,selpr,p,muty,muy,rply)

        
                                    for seed in xrange(10):
                                    
                                        filename = "%s-%s" % (prefix,str(seed))
                                        if isfile(filename):
                                            dt = opensf(filename)
                                            ranklAppend(dt['totT'])
                                            rlonAppend(calcOnline(dt["aveFit"][0]))
                                            rloffAppend(calcOffline(dt["aveBest"]))
                                            dt.close()
                                        else:
                                            with open('logwritesummaries.txt', 'a+') as l:
                                                l.write(filename + " non-existent" + '\n')
                                    
                                        
        if Sel == "tr":
            tSummary[0,0] = sum(trList)/72000
            tSummary[1,0] = np.std(trList)
            onlineperf[0] = sum(onList)/72000
            offlineperf[0,0] = sum(offList)/72000
            offlineperf[1,0] = np.std(offList)
        elif Sel == "kt":
            tSummary[0,1] = sum(ktList)/72000
            tSummary[1,1] = np.std(ktList)
            onlineperf[1] = sum(onList)/72000
            offlineperf[0,1] = sum(offList)/72000
            offlineperf[1,1] = np.std(offList)
        elif Sel == "rank":
            tSummary[0,2] = sum(rankeList)/72000
            tSummary[1,2] = np.std(rankeList)
            onlineperf[2] = sum(onList)/72000
            offlineperf[0,2] = sum(offList)/72000
            offlineperf[1,2] = np.std(offList)
        elif Sel == "rw":
            tSummary[0,4] = sum(rwList)/72000
            tSummary[1,4] = np.std(rwList)
            onlineperf[4] = sum(onList)/72000
            offlineperf[0,4] = sum(offList)/72000
            offlineperf[1,4] = np.std(offList)
            
        if Sel2 == "rankl":
            tSummary[0,3] = sum(ranklList)/72000
            tSummary[1,3] = np.std(ranklList)
            onlineperf[3] = sum(rlonList)/72000
            offlineperf[0,3] = sum(rloffList)/72000
            offlineperf[1,3] = np.std(rloffList)
    
    #1          
    np.savetxt("/home/edith/Documents/GA/results/times/SPS-times-summary.csv", tSummary, delimiter = ",", header = "tr,kt,ranke,rankl,rw")
    #2
    np.savetxt("/home/edith/Documents/GA/results/summaries/SPS-online-performance.csv", onlineperf, delimiter = ",", header = "tr,kt,ranke,rankl,rw")
    #3
    np.savetxt("/home/edith/Documents/GA/results/summaries/SPS-offline-performance.csv", offlineperf, delimiter = ",", header = "tr,kt,ranke,rankl,rw")
                                    
                                    
