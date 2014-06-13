/*
 * Point.hpp
 *
 *  Created on: Jan 13, 2014
 *      Author: kapi
 */

#ifndef POINT_HPP_
#define POINT_HPP_

#include <boost/interprocess/managed_shared_memory.hpp>
#include <boost/interprocess/containers/vector.hpp>
#include <boost/interprocess/allocators/allocator.hpp>
#include <boost/interprocess/smart_ptr/shared_ptr.hpp>
#include <boost/interprocess/smart_ptr/deleter.hpp>

#include <cmath>

class Point;

typedef boost::interprocess::managed_shared_memory::segment_manager segment_manager_type;
typedef boost::interprocess::allocator<void, segment_manager_type> void_allocator_type;

typedef boost::interprocess::deleter<Point, segment_manager_type> point_deleter_type;
typedef boost::interprocess::shared_ptr<Point, void_allocator_type, point_deleter_type> point_shared_ptr;

typedef boost::interprocess::allocator<point_shared_ptr, boost::interprocess::managed_shared_memory::segment_manager> point_ShmemAllocator;
typedef boost::interprocess::vector<point_shared_ptr, point_ShmemAllocator> points_vector;

class Point
{
	private:
		long double lat, lon;

	public:
		Point(long double lo, long double la)
	{
			lat = la;
			lon = lo;
	}

		long double getLat() const
		{
			return lat;
		}

		long double getLon() const
		{
			return lon;
		}

		friend std::ostream& operator<<(std::ostream& s, const Point& e)
		{
			s << "(" << e.lon << ", " << e.lat << ")";
			return s;
		}

		friend long double operator-(const Point& i, const Point& p)
		{
			long double cosphi = sin(i.lat * M_PI / 180) * sin(p.lat * M_PI / 180) +
					cos(i.lat * M_PI / 180) * cos(p.lat * M_PI / 180) *
					cos((i.lon - p.lon) * M_PI / 180);

			return acos(cosphi) * 6731000;
			//return sqrt(pow(i.point->getX() - p.getX(), 2) + pow(i.point->getY() - p.getY(), 2));
		}
};

#endif /* POINT_HPP_ */
