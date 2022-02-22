import random, pdb

def perchromosome(Chromosome, mu):

    #uniform distribution
    if random.random() < mu:
        b = random.randint(0,5)
        if Chromosome [b]:
            Chromosome [b] = 0
        else: 
            Chromosome [b] = 1
    return Chromosome

def uniform(Chromosome, mu):

    for b in range(5):
        if random.random() < mu:
            if Chromosome [b]:
                Chromosome [b] = 0
            else: 
                Chromosome [b] = 1
    return Chromosome
