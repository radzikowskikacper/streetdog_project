/*
 * DatabaseThread.hpp
 *
 *  Created on: Nov 23, 2013
 *      Author: kapi
 */

#ifndef DATABASETHREAD_HPP_
#define DATABASETHREAD_HPP_

#include "BaseThread.hpp"
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <cppconn/prepared_statement.h>
#include "../objs/Exceptions.hpp"

class DatabaseThread : public BaseThread
{
	private:
	    sql::Driver* 		driver;
		sql::Connection* 	connection;

		void storeDataInDB();

		bool initConnect();

		void loadStoredData();

		void closeConnection()
		{
			if (connection)
			{
				connection -> close();
				delete (connection);
				logThreadMessage("Connection closed");
			}
		}

		void executeUpdateStatement(const sql::SQLString &str,const std:: string& msg);

		void checkConnection()
		{
			if (connection->isClosed())
			{
				logThreadMessage("Connection to database aborted. Exit.");
				exit(EXIT_FAILURE);
			}
		}

	public:
		static const std::string DBHOST;
		static const std::string LOGIN;
		static const std::string PASSWD;
		static const std::string DATABASE;

		static const sql::SQLString SELECT_USERS_QUERY;
		static const sql::SQLString SELECT_ROUTES_QUERY;
		static const sql::SQLString SELECT_EVENTS_QUERY;
		static const sql::SQLString SELECT_USERS_AND_ROUTES;

		static const sql::SQLString INSERT_TO_USERS;
		static const sql::SQLString INSERT_TO_ROUTES;
		static const sql::SQLString INSERT_TO_EVENTS;

		static const sql::SQLString DELETE_FROM_USERS;
		static const sql::SQLString DELETE_FROM_ROUTES;
		static const sql::SQLString DELETE_FROM_EVENTS;

		DatabaseThread(std::string name_)//, boost::shared_ptr<Log> l_) :
				:BaseThread(name_)//, l_)
		{
			initConnect();


			loadStoredData();
		}
		~DatabaseThread()
		{
			//closeConnection();
		}

		void operator()();
};

#endif /* DATABASETHREAD_HPP_ */
