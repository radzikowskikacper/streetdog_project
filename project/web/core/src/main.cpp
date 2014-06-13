#include <iostream>
#include <boost/smart_ptr/shared_ptr.hpp>
#include <boost/smart_ptr/scoped_ptr.hpp>
#include <boost/make_shared.hpp>
#include <boost/interprocess/shared_memory_object.hpp>
#include <boost/interprocess/mapped_region.hpp>
#include <boost/thread.hpp>

#include "threads/DataThread.hpp"
#include "threads/DatabaseThread.hpp"

//#include <csignal>

Log* allocateSharedMemory(boost::scoped_ptr<boost::interprocess::managed_shared_memory>&);

struct SharedMemoryHandler
{
		SharedMemoryHandler()
		{
			boost::interprocess::named_mutex::remove(BaseThread::USERS_MUTEX_NAME.c_str());
			boost::interprocess::named_mutex::remove(BaseThread::EVENTS_MUTEX_NAME.c_str());

			boost::interprocess::shared_memory_object::remove(BaseThread::SEGMENT_NAME.c_str());
		}

		~SharedMemoryHandler()
		{
			boost::interprocess::named_mutex::remove(BaseThread::USERS_MUTEX_NAME.c_str());

			boost::interprocess::shared_memory_object::remove(BaseThread::SEGMENT_NAME.c_str());
		}

} memory_handler;

int main()
{



	boost::scoped_ptr<boost::interprocess::managed_shared_memory> seg(
			new boost::interprocess::managed_shared_memory(boost::interprocess::create_only, BaseThread::SEGMENT_NAME.c_str(), 165536));

	Log* log = allocateSharedMemory(seg);

	log->log("System startup process initialized. Creating threads");

	boost::scoped_ptr<DatabaseThread> db(new DatabaseThread("Database"));
	boost::scoped_ptr<DataThread> data(new DataThread("Data"));

	boost::thread c(*db);
	boost::thread d(*data);

	c.join();
	d.join();

	log->log("Turning off");
}

Log* allocateSharedMemory(boost::scoped_ptr<boost::interprocess::managed_shared_memory>& seg)
{
	using namespace boost::interprocess;

	Log* log = seg->construct<Log>(BaseThread::LOG_OBJECT_NAME.c_str())();
	log->addOutputStream(std::cout);
	log->log("Allocating shared memory");

	named_mutex(create_only, BaseThread::USERS_MUTEX_NAME.c_str());
	named_mutex(create_only, BaseThread::EVENTS_MUTEX_NAME.c_str());

	const user_ShmemAllocator user_alloc_inst(seg->get_segment_manager());
	const event_ShmemAllocator event_alloc_inst(seg->get_segment_manager());

	seg->construct<users_vector>(BaseThread::USERS_VECTOR_NAME.c_str())(user_alloc_inst);
	seg->construct<events_vector>(BaseThread::EVENTS_VECTOR_NAME.c_str())(event_alloc_inst);



	return log;
}
