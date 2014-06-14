'''
Created on Dec 26, 2013

@author: kapi
'''

import web
from libdatabridge import DataBridge

db = web.database(dbn='mysql', user='zpr', pw='zpr', db='streetguard')
data = DataBridge("DataBridge")
