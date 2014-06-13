/*
 * DataThread.cpp
 *
 *  Created on: Dec 26, 2013
 *      Author: kapi
 */

#include "DataThread.hpp"

void DataThread::operator()()
{
	logThreadMessage("Entered thread");

	boost::posix_time::ptime now;
	std::stringstream ss;

	while(true)
	{

		{
			logThreadMessage("Locking events");
			boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*events_mutex);
			logThreadMessage("Locked events");

			now = boost::posix_time::second_clock::local_time();
			for(events_vector::iterator it = events->begin(); it != events->end();)
			{
				boost::posix_time::time_duration td(now - (*it)->getLastUp());

				if(td > boost::posix_time::seconds(60 * 30))
				{
					ss.str("");
					ss << "Removing event: " << **it;

					it = events->erase(it);
				}
				else
				{
					ss.str("");
					ss << "Event " << **it;
					++it;
				}

				logThreadMessage(ss.str());
			}
		}

		{
			logThreadMessage("Locking users");
			boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*users_mutex);
			logThreadMessage("Locked users");

			for(users_vector::iterator it = users->begin(); it != users->end();)
			{
				boost::posix_time::time_duration td(now - (*it)->getLastRequest());
				ss.str("");
				ss << **it << " " << td;

				if(td > boost::posix_time::seconds(600))
				{
					ss.str("");
					ss << "Removing user: " << **it;

					try
					{
						points_vector& ppp = (*it)->getRoute(seg);

						for(point_shared_ptr& ptshrptr : ppp)
							seg->destroy_ptr(&(*ptshrptr));

						seg->destroy_ptr(&ppp);

					}
					catch(NullPointerRouteException &e)
					{

					}

					it = users->erase(it);
				}
				else
				{
					ss.str("");
					ss << "User " << **it;
					++it;
				}

				logThreadMessage(ss.str());
			}
		}

		boost::this_thread::sleep(boost::posix_time::milliseconds(5000));
	}
}

