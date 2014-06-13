'''
Created on Dec 25, 2013

@author: kapi
'''

import json, web

from utils import data

class users:
    def POST(self):
        ret = {}
        ret['id'] = data.newDevice()
        
        return json.dumps(ret)