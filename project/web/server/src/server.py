'''
Created on Dec 24, 2013

@author: kapi
'''

import web, users, events, tracks, poll

web.config.Debug=True

urls = (
    '/events/?', 'events.events',
    '/users/?', 'users.users',
    '/tracks/?', 'tracks.tracks',
    '/track/(\d+)/?', 'tracks.track',
    '/poll/(\d+)/?', 'poll.poller'
)

def main():
    app = web.application(urls, globals())
    app.run()
