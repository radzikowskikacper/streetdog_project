'''
Created on Jan 15, 2014

@author: kapi
'''

import web, json
from utils import data
from libdatabridge import BadUserIDException
from libdatabridge import NullPointerRouteException

class poller:
    def GET(self, uid):        
        try:
            events = data.pollTrackEvents(int(uid))
            
        except BadUserIDException, e:
            raise web.NotFound(e.message)
        except NullPointerRouteException, e:
            raise web.NotFound(e.message);
        
        return json.dumps(events)