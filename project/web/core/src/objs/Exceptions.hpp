/*
 * Exceptions.hpp
 *
 *  Created on: Dec 15, 2013
 *      Author: kapi
 */

#ifndef EXCEPTIONS_HPP_
#define EXCEPTIONS_HPP_

// basically exception
class BaseException : public std::exception
{
	protected:
	  std::string message;

	public:
	  BaseException(std::string message)
	  {
	    this->message = message;
	  }

	  const char *what() const throw()
	  {
	    return this->message.c_str();
	  }

	  virtual ~BaseException() throw()
	  {
	  }

	  std::string getMessage()
	  {
	    return this->message;
	  }
};

class NullPointerRouteException: public BaseException
{
public:
	NullPointerRouteException(std::string message) : BaseException(message)
  {
  }
};

class DataBaseError : public BaseException
{

};

class EventMergedException : public BaseException
{
	public:
	  EventMergedException(std::string message) : BaseException(message)
	  {
	  }
};


class NoTrackException : public BaseException
{
	public:
	NoTrackException(std::string message) : BaseException(message)
	  {
	  }
};

// exception for server thread throwas when Android Application query about device id that isn't stored in server.
class BadUserIDException : public BaseException
{
	public:
	  BadUserIDException(std::string message) : BaseException(message)
	  {
	  }
};

// exception during deleteing data from tables
class DeleteException: public DataBaseError
{

};

#endif /* EXCEPTIONS_HPP_ */
