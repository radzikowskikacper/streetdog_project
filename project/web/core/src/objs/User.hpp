/*
 * User.hpp
 *
 *  Created on: Nov 18, 2013
 *      Author: kapi
 */

#ifndef USER_HPP_
#define USER_HPP_

#include <boost/interprocess/sync/interprocess_mutex.hpp>
#include <boost/shared_ptr.hpp>
#include "Point.hpp"
#include "../objs/Exceptions.hpp"

class User;

typedef boost::interprocess::managed_shared_memory::segment_manager segment_manager_type;
typedef boost::interprocess::allocator<void, segment_manager_type> void_allocator_type;

typedef boost::interprocess::deleter<User, segment_manager_type> user_deleter_type;
typedef boost::interprocess::shared_ptr<User, void_allocator_type, user_deleter_type> user_shared_ptr;

typedef boost::interprocess::allocator<user_shared_ptr, boost::interprocess::managed_shared_memory::segment_manager> user_ShmemAllocator;
typedef boost::interprocess::vector<user_shared_ptr, user_ShmemAllocator> users_vector;


typedef boost::interprocess::managed_shared_memory man_shm;

typedef boost::interprocess::allocator<void, segment_manager_type> void_allocator_type;

typedef boost::interprocess::deleter<boost::posix_time::ptime, segment_manager_type> ptime_deleter_type;
typedef boost::interprocess::shared_ptr<boost::posix_time::ptime, void_allocator_type, ptime_deleter_type> ptime_shared_ptr;


class User
{
	private:
		long long id;

		double x;
		double y;
		double z;

		ptime_shared_ptr last_request;

		//points_vector* route;


	public:
		User(long long id, ptime_shared_ptr time) :
				id(id),last_request(time)
		{
			//update();
		}

		long long getId()
		{
			return id;
		}

		void update()
		{
			(*last_request) = boost::posix_time::second_clock::local_time();
		}



		void setRoute(boost::shared_ptr<boost::interprocess::managed_shared_memory> &seg,
				boost::interprocess::vector<point_shared_ptr> &local_route_vector)
		{
			const point_ShmemAllocator point_alloc_inst(seg->get_segment_manager());

			std::stringstream strd;
			strd << "vptptr" << id;

			points_vector *route_vector = seg->find_or_construct<points_vector>(strd.str().c_str())(point_alloc_inst);

			if ( route_vector->size() )
				route_vector->clear();

			for(point_shared_ptr& i : local_route_vector)
			{
				route_vector->push_back(i);
			}

		}

		points_vector&  getRoute (boost::shared_ptr<boost::interprocess::managed_shared_memory> &seg)
				throw (NullPointerRouteException)
		{
			std::stringstream strd;
			strd << "vptptr" << id;
			points_vector* el = seg->find<points_vector>(strd.str().c_str()).first;

			if (el == nullptr)
				throw NullPointerRouteException("Isn't any route associated with user");
			return *el;
		}

		void setTime(boost::posix_time::ptime& time)
		{
			(*last_request) = time;
		}

		const boost::posix_time::ptime& getLastRequest() const
		{
			return *last_request;
		}

		friend std::ostream& operator<<(std::ostream& str, const User& u)
		{
			str << u.id << " " << (*u.last_request);
			return str;
		}
};

#endif /* USER_HPP_ */
