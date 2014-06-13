/*
 * DatabaseThread.cpp
 *
 *  Created on: Dec 26, 2013
 *      Author: kapi
 */

#include "DatabaseThread.hpp"

const std::string DatabaseThread:: DBHOST 		= 		"tcp://127.0.0.1:3306";
const std::string DatabaseThread:: PASSWD 		= 		"zpr";
const std::string DatabaseThread:: LOGIN 		= 		"zpr";
const std::string DatabaseThread:: DATABASE 	= 		"streetguard";

const sql::SQLString DatabaseThread::SELECT_USERS_QUERY		 = "SELECT * FROM users ORDER BY id";
const sql::SQLString DatabaseThread::SELECT_ROUTES_QUERY	 = "SELECT * FROM routes ORDER BY user_id, id";
const sql::SQLString DatabaseThread::SELECT_EVENTS_QUERY	 = "SELECT id, point_lat, point_lon, event_type, DATE_FORMAT(time,'%Y-%m-%d %H:%i:%s.000') as time, acc from events";
const sql::SQLString DatabaseThread::SELECT_USERS_AND_ROUTES = "SELECT users.id, users.last_request, routes.id, routes.point_lat, routes.point_lon "
															   "FROM users LEFT JOIN routes ON users.id = routes.user_id "
															   "ORDER BY users.id, routes.id";
const sql::SQLString DatabaseThread::INSERT_TO_USERS = 	"INSERT INTO users(id, last_request) VALUES (?, ?)";
const sql::SQLString DatabaseThread::INSERT_TO_ROUTES = "INSERT INTO routes(id, user_id, point_lat, point_lon) VALUES (?, ?, ?, ?)";
const sql::SQLString DatabaseThread::INSERT_TO_EVENTS = "INSERT INTO events(id, point_lat, point_lon, event_type, time, acc) VALUES (?, ?, ?, ?, ?, ?)";

const sql::SQLString DatabaseThread::DELETE_FROM_USERS  = "DELETE FROM users";
const sql::SQLString DatabaseThread::DELETE_FROM_ROUTES = "DELETE FROM routes";
const sql::SQLString DatabaseThread::DELETE_FROM_EVENTS = "DELETE FROM events";


typedef boost::scoped_ptr<sql::Statement> StatementPtr;
typedef boost::scoped_ptr<sql::PreparedStatement> PreparedStatementPtr;
typedef boost::scoped_ptr<sql::ResultSet> ResultSetPtr;

//typedef boost::interprocess::anonymous_instance anonymous_inst;


void DatabaseThread::executeUpdateStatement(const sql::SQLString &str, const std:: string& msg)
		{

			checkConnection();

			StatementPtr statement (connection -> createStatement());
			if ( statement -> executeUpdate(str))
				logThreadMessage(msg);
			else
			{
				//throw DeleteException( std::string("Problem with delete data from table users"));
			}
		}

void DatabaseThread::storeDataInDB()
{
	checkConnection();

	std::stringstream ss;

	logThreadMessage("Preparing data to store to database...");
	try{
		{








			users_vector::iterator it =  users -> begin();
			users_vector::iterator it_end =  users -> end();


			executeUpdateStatement(DELETE_FROM_ROUTES, std::string("Delete old data from table routes"));
			executeUpdateStatement(DELETE_FROM_USERS, std::string("Delete old data from table users"));


			
			// add user records to table user
			PreparedStatementPtr prep_statement (connection->prepareStatement(INSERT_TO_USERS));

			long int num_el_us = 0;
			for (;it != it_end; ++it)
			{
				// id user
				prep_statement ->setInt64(1, (*it)->getId() );

				ss.str("");
				ss << boost::posix_time::to_iso_string ((*it)->getLastRequest()).substr(0,20);
				// last query (time)
				prep_statement-> setDateTime( 2, ss.str());

				num_el_us += prep_statement->executeUpdate();

			}

			ss.str("");
			ss << "Added " << num_el_us <<" records to table users";
			logThreadMessage(ss.str());



			prep_statement.reset( connection->prepareStatement(INSERT_TO_ROUTES) );

			long int num_el_point_route=0;
			it =  users -> begin();
			it_end =  users -> end();
			int nr = 0; // id point route
			for (;it != it_end; ++it)
			{
				// store route data for users
				try
				{
					points_vector::iterator pt_it = (*it)-> getRoute(seg).begin();
					points_vector::iterator pt_it_end = (*it)-> getRoute(seg).end();
					logThreadMessage("Add route to user");
					for (;pt_it != pt_it_end; ++pt_it)
					{
						// id route
						prep_statement -> setInt64(1 , ++nr);
						// user id
						prep_statement -> setInt64(2,(*it)->getId() );
						// point lat
						prep_statement -> setDouble(3,(*pt_it)->getLat() );
						// point lon
						prep_statement -> setDouble(4,(*pt_it)->getLon() );
						num_el_point_route += prep_statement->executeUpdate();
					}

				}
				catch (NullPointerRouteException &e)
				{
					// for users without assigned routes
				}
			} // end for


			ss.str("");
			ss << "Added " << num_el_point_route << " records (points) to table routes";
			logThreadMessage(ss.str());

		}

		// store events data
		{
			executeUpdateStatement(DELETE_FROM_EVENTS, std::string("Delete old data from table events"));

			PreparedStatementPtr prep_statement (connection->prepareStatement(INSERT_TO_EVENTS));

			events_vector::iterator it =  events -> begin();
			events_vector::iterator it_end =  events -> end();

			long int num_el_ev = 0;
			for (;it != it_end; ++it)
			{
				ss.str("");
				ss << boost::posix_time::to_iso_string ((*it)->getLastUp()).substr(0,20);
				// id evet
				prep_statement -> setInt64(1, (*it)->getId() );
				// point lat
				prep_statement -> setDouble(2,(*it)->getPoint()->getLat() );
				// point lon
				prep_statement -> setDouble(3,(*it)->getPoint()->getLon() );
				// event type
				prep_statement -> setInt(4,(*it)->getType() );
				// time
				prep_statement -> setDateTime(5, ss.str() );
				// acc
				prep_statement -> setDouble(6,(*it)->getAcc() );


				num_el_ev += prep_statement->executeUpdate();

			}

			ss.str("");
			ss << "Added " << num_el_ev <<" records to table events";
			logThreadMessage(ss.str());

		}
		// save the changes into the database
		connection -> commit();
	}

	catch (sql::SQLException &e)
	{
		connection->rollback();
		std::stringstream error;
		error << "ERROR SQL Exception on store data to database: " << e.what() << "(MySQL error code: " << e.getErrorCode() << ", SQLState: "
				<< e.getSQLState() << ")";
		logThreadMessage(error.str());
	}
	catch (DeleteException &e)
	{
		logThreadMessage(e.what());
	}


}

void DatabaseThread::operator()()
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

			{
				logThreadMessage("Locking users");
				boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*users_mutex);
				logThreadMessage("Locked users");

				storeDataInDB();
			}
		}

		boost::this_thread::sleep(boost::posix_time::milliseconds(5000));
	}
}

bool DatabaseThread::initConnect()
{
	try{
		std::stringstream link;
		link << DBHOST << '/' << DATABASE;

		driver =  get_driver_instance();
		connection = driver -> connect(link.str(), LOGIN, PASSWD);

		logThreadMessage("Established connection to database");

	}
	catch (sql::SQLException &e)
	{

		std::stringstream error;
		error << "ERROR SQL EXception on init: " << e.what() << "(MySQL error code: " << e.getErrorCode() << ", SQLState: "
				<< e.getSQLState() << ")";

		logThreadMessage(error.str());

		exit(EXIT_FAILURE);

	}
	catch (std::runtime_error &e) {
		log->log("ERROR: runtime_error");
		exit (EXIT_FAILURE);
	}

	connection -> setAutoCommit(0);

	return true;
}


void DatabaseThread::loadStoredData()
{
	if ( connection -> isClosed() )
	{
		logThreadMessage("Connection to database aborted. Exit.");
		exit(EXIT_FAILURE);
	}

	std::stringstream ss;

	try{
		using namespace boost::interprocess;

		// load users data
		{
			logThreadMessage("Locking users");
			boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*users_mutex);
			logThreadMessage("Locked users");

			StatementPtr statement( connection->createStatement() );
			ResultSetPtr result( statement->executeQuery(DatabaseThread::SELECT_USERS_AND_ROUTES) );

			int last_user_id = -1;
			int loaded_user_id = 0;

			boost::posix_time::ptime *time = nullptr;

			boost::shared_ptr<vector<point_shared_ptr>> pts(new vector<point_shared_ptr>());

			const point_ShmemAllocator point_alloc_inst(seg->get_segment_manager());

			// load data users with route points
			while ( result -> next() )
			{

				if (last_user_id != (loaded_user_id = result -> getInt64(1)) )
				{// when we load next user

					ss.str("");

					if (last_user_id != -1)
					{// if was user before then save his route
						(*users->rbegin())->setRoute(seg,*pts);
						(*users->rbegin())->setTime(*time );

					}

					last_user_id = loaded_user_id;

					// load time from base
					boost::posix_time::ptime event_time = boost::posix_time::time_from_string(result -> getString(2));
					time = &event_time;

					ptime_shared_ptr& time = *seg->construct<ptime_shared_ptr>(anonymous_instance)(seg->construct<boost::posix_time::ptime>(anonymous_instance)(event_time),
							void_allocator_type(seg->get_segment_manager()), ptime_deleter_type(seg->get_segment_manager()));

					user_shared_ptr &shared_ptr_instance = *seg->construct<user_shared_ptr>(anonymous_instance)(seg->construct<User>(anonymous_instance)(loaded_user_id,time),
							void_allocator_type(seg->get_segment_manager()), user_deleter_type(seg->get_segment_manager()));

					// reset route points vector for new route
					pts.reset( new vector<point_shared_ptr>() );

					// save user to shared memory object
					users -> push_back(shared_ptr_instance);
					seg->destroy_ptr(&time);

					ss << "loaded user with id: "<< loaded_user_id;
					logThreadMessage(ss.str());

				}
				if (result -> isNull(3))
					// user without assigned route
					continue;
				// load route for user
				point_shared_ptr& pt = *seg->construct<point_shared_ptr>(anonymous_instance)(seg->construct<Point>(anonymous_instance)(result -> getDouble(5), result -> getDouble(4)),
						void_allocator_type(seg->get_segment_manager()), point_deleter_type(seg->get_segment_manager()));

				pts->push_back(pt);

				seg->destroy_ptr(&pt);

			}
			if (last_user_id != -1)
			{ // step correction for last user if was at least one user
				(*users->rbegin())->setRoute(seg,*pts);
				(*users->rbegin())->setTime(*time);
			}


			// TODO setTime
			connection -> commit();


		}
		// load events data
		{
			StatementPtr statement( connection->createStatement() );
			ResultSetPtr result( statement->executeQuery(DatabaseThread::SELECT_EVENTS_QUERY) );

			logThreadMessage("Locking events");
			boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*events_mutex);
			logThreadMessage("Locked events");

			while (result -> next())
			{


				ss.str("");
				ss << "Added event with id:" << result -> getInt64(1);
				logThreadMessage(ss.str());

				boost::posix_time::ptime event_time = boost::posix_time::time_from_string(result -> getString(5));


				ptime_shared_ptr& time = *seg->construct<ptime_shared_ptr>(anonymous_instance)(seg->construct<boost::posix_time::ptime>(anonymous_instance)(event_time),
						void_allocator_type(seg->get_segment_manager()), ptime_deleter_type(seg->get_segment_manager()));

				point_shared_ptr& pt = *seg->construct<point_shared_ptr>(anonymous_instance)(seg->construct<Point>(anonymous_instance)(result -> getDouble(3),result -> getDouble(2)),
						void_allocator_type(seg->get_segment_manager()), point_deleter_type(seg->get_segment_manager()));

				event_shared_ptr& shared_ptr_instance = *seg->construct<event_shared_ptr>(anonymous_instance)(
						seg->construct<Event>(anonymous_instance)(result -> getInt64(1), pt, result -> getInt(4),result -> getDouble(6), time ), void_allocator_type(seg->get_segment_manager()),
						event_deleter_type(seg->get_segment_manager()));

				
				events->push_back(shared_ptr_instance);

				seg->destroy_ptr(&time);
				seg->destroy_ptr(&pt);
				seg->destroy_ptr(&shared_ptr_instance);

			}

			connection -> commit();

		}

	}
	catch (sql::SQLException &e)
	{
		std::stringstream error;
		error << "ERROR SQL Exception on load data to shared memory: " << e.what() << "(MySQL error code: " << e.getErrorCode() << ", SQLState: "
				<< e.getSQLState() << ")";
		logThreadMessage(error.str());
	}
}
