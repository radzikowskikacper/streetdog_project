'''
Created on Dec 25, 2013

@author: kapi
'''

import json, web
from utils import data
from databridge import EventMergedException
from databridge import BadUserIDException

class events:
    def POST(self):
        event_data = json.loads(web.data())
        
        type = int(event_data['type'])
        lo = float(event_data['lo'])
        la = float(event_data['la'])
        acc = float(event_data['acc'])
        uid = int(event_data['uid']);
        
        try:
            data.newEvent(type, lo, la, acc, uid)
        except EventMergedException, e:
            raise web.Conflict(e.message)
        except BadUserIDException, e:
            raise web.NotFound(e.message);
        
        raise web.Created()
        
    
        
        