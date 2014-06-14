# -*- coding: utf-8 -*-

'''
Created on Dec 26, 2013

@author: kapi
'''


import web, json
from utils import data
from libdatabridge import BadUserIDException

class tracks:
    def POST(self):
        #track addition
        dt = json.loads(web.data())
        
        try:
            data.newTrack(dt['uid'], dt['track']);
        except BadUserIDException, e:
            raise web.NotFound(e.message)
        
        raise web.Created()

class track:
    def PUT(self, uid):
        dt = json.loads(web.data())
        
        try:
            data.newTrack(int(uid), dt['track']);
        except BadUserIDException, e:
            raise web.NotFound(e.message)
        
        raise web.NoContent()