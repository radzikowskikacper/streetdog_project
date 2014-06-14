#ifndef CPPDATABRIDGE
#define CPPDATABRIDGE

#include <boost/python.hpp>
#include <boost/python/dict.hpp>
#include <boost/interprocess/sync/scoped_lock.hpp>

#include <math.h>

#include "core/src/threads/BaseThread.hpp"
#include "core/src/objs/Exceptions.hpp"

class DataBridge : public BaseThread
{
	private:
		long long free_event_id;

		user_shared_ptr& getUser(long long id);

		boost::python::list checkTrackCollision(points_vector* pts);

	public:

		DataBridge(std::string name_) :
				BaseThread(name_), free_event_id(-1)
		{
		}

		long long int newDevice();

		void newEvent(short, long double, long double, double, long long);

		void deleteEvent();
		void newTrack(long long, boost::python::list);

		boost::python::list pollTrackEvents(long long);
};

long double getLowerCoordinate(long double a, long double b)
{
	return a < b ? a : b;
}

long double getHigherCoordinate(long double a, long double b)
{
	return a > b ? a : b;
}


	PyObject* custom_event_exception = NULL;
	PyObject* custom_id_exception = NULL;
	PyObject* custom_track_exception = NULL;

	void exceptionEventTranslateFunc(EventMergedException const &e)
	{
		boost::python::object pythonExceptionInstance(e);
		PyErr_SetObject(custom_event_exception, pythonExceptionInstance.ptr());
	}

	void exceptionIDTranslateFunc(BadUserIDException const &e)
	{
		boost::python::object pythonExceptionInstance(e);
		PyErr_SetObject(custom_id_exception, pythonExceptionInstance.ptr());
	}

	void exceptionTrackTranslateFunc(NullPointerRouteException const &e)
	{
		boost::python::object pythonExceptionInstance(e);
		PyErr_SetObject(custom_track_exception, pythonExceptionInstance.ptr());
	}

	BOOST_PYTHON_MODULE(libdatabridge)
	{
		using namespace boost::python;

		class_<EventMergedException> EventMergedExceptionClass("EventMergedException", init<std::string>());
		class_<BadUserIDException> BadUserIDExceptionClass("BadUserIDException", init<std::string>());
		class_<NullPointerRouteException> NullPointerRouteExceptionClass("NullPointerRouteException", init<std::string>());

		EventMergedExceptionClass.add_property("message", &BaseException::getMessage);
		BadUserIDExceptionClass.add_property("message", &BaseException::getMessage);
		NullPointerRouteExceptionClass.add_property("message", &BaseException::getMessage);


		custom_event_exception = EventMergedExceptionClass.ptr();
		custom_id_exception = BadUserIDExceptionClass.ptr();
		custom_track_exception = NullPointerRouteExceptionClass.ptr();

		register_exception_translator<EventMergedException>(&exceptionEventTranslateFunc);
		register_exception_translator<BadUserIDException>(&exceptionIDTranslateFunc);
		register_exception_translator<NullPointerRouteException>(&exceptionTrackTranslateFunc);

		class_<DataBridge>("DataBridge", init<std::string>())
				.def("newDevice", &DataBridge::newDevice)
				.def("newEvent", &DataBridge::newEvent)
				.def("newTrack", &DataBridge::newTrack)
				.def("pollTrackEvents", &DataBridge::pollTrackEvents);
	}


#endif
