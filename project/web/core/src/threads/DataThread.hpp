/*
 * DataThread.hpp
 *
 *  Created on: Nov 23, 2013
 *      Author: kapi
 */

#ifndef DATATHREAD_HPP_
#define DATATHREAD_HPP_

#include <string>

#include "BaseThread.hpp"

class DataThread : public BaseThread
{
	private:
		void allocateSharedMemory();

	public:
		DataThread(std::string name_);

		void operator()();
};

#endif /* DATATHREAD_HPP_ */
