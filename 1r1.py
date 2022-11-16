
# coding: utf-8

# In[16]:


from umi_tools import network as nk
import umi_tools as umi
import numpy as np
import sys
import pandas as pd
import numpy as np, matplotlib.pyplot as plt, networkx as nx, pickle, json, gzip
import sys


# In[2]:


f1 = sys.argv[1]
HD = sys.argv[2].encode('utf-8')
N_READS = int(sys.argv[3])


# In[57]:


library1 = np.loadtxt(f1,dtype=str,delimiter='/n')



library1 = [i[35:63] for i in library1]


library1 = np.loadtxt(library1,dtype=str,delimiter='/n')


# In[58]:


library1.shape



# In[59]:


def is_valid(bc):
	return bc[4:6]=='TG' and bc[10:12]=='CA' and bc[16:18]=='AC' and bc[22:24]=='GA'


# In[60]:


out = open('filtered_'+f1, 'wb')

library1_clean = []
for xx in library1:
    if is_valid(xx):
        library1_clean.append(xx)
        out.write((xx+'\n').encode('utf-8'))
        out.write('\n'.encode('utf-8'))


# In[61]:

# In[62]:


barcodes_unique1 = np.unique(library1_clean)



# In[63]:


print(barcodes_unique1.shape)



# In[64]:


###Here we generate a list of barcodes filtered by minimum number of reads, and print it in csv form

barcodes1 , barcodes_counts1 = np.unique(library1_clean, return_counts=True)
cbc1 = dict(zip(barcodes1, barcodes_counts1))
cbc1_filtered = {k:v for k,v in cbc1.items() if v >= N_READS}
print('Replicate 1 retaining '+repr(len(cbc1_filtered))+ ' out of '+repr(len(cbc1))+' barcodes')
library1_df = pd.DataFrame.from_dict(cbc1_filtered, orient='index')
library1_df.to_csv('library1_min_'+repr(N_READS)+'_reads.csv', '\t')



#these are used in R to merge two lists

#sample34r1<-merge(lib1, lib2, by.x="seq1", by.y="seq2")
#sample34r1$sum_freq<-sample34r1$freq1+sample34r1$freq2

#sample34r1$realfreq<-sample34r1$sum_freq/sum(sample34r1$sum_freq)

#write.csv(sample34r1,file="sample34r1.csv")
