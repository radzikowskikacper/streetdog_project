/*
 * BaseThread.hpp
 *
 *  Created on: Nov 24, 2013
 *      Author: kapi
 */

#ifndef BASETHREAD_HPP_
#define BASETHREAD_HPP_

#include "../Log.hpp"
#include "../objs/User.hpp"
#include "../objs/Event.hpp"

#include <string>
#include <memory>
#include <boost/scoped_ptr.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/thread.hpp>
#include <boost/interprocess/sync/named_mutex.hpp>
#include <boost/interprocess/managed_shared_memory.hpp>
#include <boost/interprocess/smart_ptr/shared_ptr.hpp>

class BaseThread
{
	protected:
		std::string name;

		boost::shared_ptr<boost::interprocess::managed_shared_memory> seg;

		Log* log;
		boost::shared_ptr<boost::interprocess::named_mutex> users_mutex;
		boost::shared_ptr<boost::interprocess::named_mutex> events_mutex;

		users_vector* users;
		events_vector* events;

		void logThreadMessage(std::string msg)
		{
			std::stringstream ss;

			ss << "[ " << name << " ] " << msg;

			log->log(ss.str());
		}

		void loadSharedMemory();

	public:
		static const std::string USERS_MUTEX_NAME;
		static const std::string USERS_VECTOR_NAME;

		static const std::string EVENTS_MUTEX_NAME;
		static const std::string EVENTS_VECTOR_NAME;

		static const std::string LOG_OBJECT_NAME;
		static const std::string SEGMENT_NAME;

		BaseThread(std::string name_) : name(name_)
		{
			loadSharedMemory();
			logThreadMessage("Created thread");
		}

		virtual ~BaseThread()
		{
		}
};



#endif /* BASETHREAD_HPP_*/
