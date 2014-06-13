/*
 * User.hpp
 *
 *  Created on: Nov 18, 2013
 *      Author: kapi
 */

#ifndef EVENTS_HPP_
#define EVENTS_HPP_

#include <boost/interprocess/sync/interprocess_mutex.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

#include "Point.hpp"

class Event;

typedef boost::interprocess::deleter<Event, segment_manager_type> event_deleter_type;
typedef boost::interprocess::shared_ptr<Event, void_allocator_type, event_deleter_type> event_shared_ptr;

typedef boost::interprocess::allocator<event_shared_ptr, boost::interprocess::managed_shared_memory::segment_manager> event_ShmemAllocator;
typedef boost::interprocess::vector<event_shared_ptr, event_ShmemAllocator> events_vector;


typedef boost::interprocess::managed_shared_memory man_shm;

typedef boost::interprocess::allocator<void, segment_manager_type> void_allocator_type;

typedef boost::interprocess::deleter<boost::posix_time::ptime, segment_manager_type> ptime_deleter_type;
typedef boost::interprocess::shared_ptr<boost::posix_time::ptime, void_allocator_type, ptime_deleter_type> ptime_shared_ptr;



class Event
{
	private:
		long long id;

		point_shared_ptr point;

		short type;

		double acc;

		//boost::posix_time::ptime last_up;
		ptime_shared_ptr last_up;


public:
		const static double MIN_DISTANCE;

		Event(long long id, point_shared_ptr pt, short type, double acc, ptime_shared_ptr time) : id(id), point(pt), type(type), acc(acc), last_up(time)
		{
			//update();
		}
		//Event(long long id, point_shared_ptr pt, short type, double acc,const std::string time_str) : id(id), point(pt), type(type), acc(acc)
		//{
		//	(*last_up) = boost::posix_time::time_from_string(time_str);
		//}

		long long getId()
		{
			return id;
		}

		void update()
		{
			(*this->last_up) = boost::posix_time::second_clock::local_time();
		}

		short getType() const
		{
			return type;
		}

		void setTime(const boost::posix_time::ptime& time)
		{
			(*this->last_up) = time;
		}

		const boost::posix_time::ptime& getLastUp() const
		{
			return *last_up;
		}

		double getAcc() const
		{
			return acc;
		}

		friend std::ostream& operator<<(std::ostream& s, const Event& e)
		{
			s << e.id << " ";
			s << *(e.point) << ", ";
			s << e.type << " " << e.acc;

			return s;
		}

		point_shared_ptr& getPoint()
		{
			return point;
		}

		void setPoint(const point_shared_ptr& point)
		{
			this->point = point;
		}
};



#endif /* USER_HPP_ */
