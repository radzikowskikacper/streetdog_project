/*
 * BaseThread.cpp
 *
 *  Created on: Dec 26, 2013
 *      Author: kapi
 */

#include "BaseThread.hpp"

const std::string BaseThread::USERS_MUTEX_NAME = "users_mutex_name";
const std::string BaseThread::USERS_VECTOR_NAME = "users_vector_name";

const std::string BaseThread::EVENTS_MUTEX_NAME = "events_mutex_name";
const std::string BaseThread::EVENTS_VECTOR_NAME = "events_vector_name";

const std::string BaseThread::LOG_OBJECT_NAME = "log_object_name";
const std::string BaseThread::SEGMENT_NAME = "segment_name";

void BaseThread::loadSharedMemory()
{
	using namespace boost::interprocess;

	seg.reset(new managed_shared_memory(open_only, BaseThread::SEGMENT_NAME.c_str()));

	log = seg->find<Log>(BaseThread::LOG_OBJECT_NAME.c_str()).first;

	logThreadMessage("Loading shared memory");

	users_mutex.reset(new named_mutex(open_only, USERS_MUTEX_NAME.c_str()));
	users = seg->find<users_vector>(BaseThread::USERS_VECTOR_NAME.c_str()).first;

	events_mutex.reset(new named_mutex(open_only, EVENTS_MUTEX_NAME.c_str()));
	events = seg->find<events_vector>(BaseThread::EVENTS_VECTOR_NAME.c_str()).first;
}


