system: cppcore databridge

#core
cppcore:
	make -C core/Debug/ all

# databridge
databridge: lib module
	rm base.o c++databridge.o event.o
	mv databridge.so server/src/

lib: c++databridge.hpp
	g++ -std=c++11 -o c++databridge.o -c -fPIC -I/usr/include/python2.7 c++databridge.cpp
	
base: core/src/threads/BaseThread.hpp
	g++ -std=c++11 -o base.o -c -fPIC core/src/threads/BaseThread.cpp

event: core/src/objs/Event.hpp
	g++ -std=c++11 -o event.o -c -fPIC core/src/objs/Event.cpp

module: base event
	g++ -o databridge.so -shared c++databridge.o base.o event.o -lboost_python -lrt -lboost_system -lboost_thread

clean:
	make -C core/Debug/ clean
	rm base.o c++databridge.o server/src/dbr.so event.o
