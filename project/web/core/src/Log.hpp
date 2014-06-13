/*
 * Log.hpp
 *
 *  Created on: Nov 23, 2013
 *      Author: kapi
 */

#ifndef LOG_HPP_
#define LOG_HPP_

#include <iostream>
#include <string>
#include <sstream>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/container/vector.hpp>

class Log
{
	private:
		boost::container::vector<std::ostream*> streams;

	public:

		inline void addOutputStream(std::ostream& s)
		{
			streams.push_back(&s);
		}

		inline void log(std::string msg)
		{
			boost::posix_time::ptime now = boost::posix_time::second_clock::local_time();

			std::stringstream msgs;

			msgs << "[ " << now << " ] " << msg << "\n";
			msg = msgs.str();

			//for(std::ostream* o : streams)
				std::cout << msg;

		}
};

#endif /* LOG_HPP_ */
