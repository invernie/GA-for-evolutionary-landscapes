import analysePar
from multiprocessing import Pool
from multiprocessing.dummy import Pool as ThreadPool

#distribute simulation runs by "a" (ancestor strategy) value across cores
def run(Sel): 

    a_range = [0,0.05,0.10,0.15,0.20]

    pool = ThreadPool(12)
    if Sel == "tr":
        pool.map(analysePar.tr,a_range)

    elif Sel == "kt":
        pool.map(analysePar.kt,a_range)

    elif Sel == "rank":
        pool.map(analysePar.ranke,a_range)
        pool.map(analysePar.rankl,a_range)

    elif Sel == "rw":
        pool.map(analysePar.rw,a_range)

    pool.close()
    pool.join()
