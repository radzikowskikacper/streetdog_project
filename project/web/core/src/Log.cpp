/*
 * Log.cpp
 *
 *  Created on: Jun 13, 2014
 *      Author: kapi
 */

#include "Log.hpp"

void Log::log(std::string msg)
{
	boost::posix_time::ptime now = boost::posix_time::second_clock::local_time();

	std::stringstream msgs;

	msgs << "[ " << now << " ] " << msg << "\n";
	msg = msgs.str();

	//for(std::ostream* o : streams)
		std::cout << msg;
}


