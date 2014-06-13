#include "c++databridge.hpp"

long long int DataBridge::newDevice()
{
	long long int ret;

	logThreadMessage("Locking users mutex");
	boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*users_mutex);

	logThreadMessage("Locked");

	std::stringstream nameptr, nameobj;

	if(users->size() == 0)
		ret = 0;
	else
		ret = (*users->rbegin())->getId()+1;

	nameptr << "Creating new user ID: " << ret;
	logThreadMessage(nameptr.str());

	nameptr.clear();
	nameptr << "ptrd" << ret;
	nameobj << "objd" << ret;

	boost::posix_time::ptime event_time =(boost::posix_time::second_clock::local_time());

	ptime_shared_ptr& time = *seg->construct<ptime_shared_ptr>(boost::interprocess::anonymous_instance)(seg->construct<boost::posix_time::ptime>(boost::interprocess::anonymous_instance)(event_time),
			void_allocator_type(seg->get_segment_manager()), ptime_deleter_type(seg->get_segment_manager()));

	user_shared_ptr &shared_ptr_instance = *seg->construct<user_shared_ptr>(nameptr.str().c_str())(seg->construct<User>(nameobj.str().c_str())(ret,time),
			void_allocator_type(seg->get_segment_manager()), user_deleter_type(seg->get_segment_manager()));

	users->push_back(shared_ptr_instance);

	seg->destroy_ptr(&time);
	seg->destroy_ptr(&shared_ptr_instance);
	logThreadMessage("Unlocking users mutex");

	return ret;
}

void DataBridge::newEvent(short type, long double lo, long double la, double acc, long long uid)
{
	long long id = free_event_id;

	{
		logThreadMessage("Locking users mutex");
		boost::interprocess::scoped_lock<boost::interprocess::named_mutex> locu(*users_mutex);

		(getUser(uid))->update();
	}

	logThreadMessage("Locking events mutex");
	boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*events_mutex);

	logThreadMessage("Locked");

	std::stringstream nameptr, nameobj;

	logThreadMessage("Trying to merge with another event");

	Point p(lo, la);

	for(event_shared_ptr& i : *events)
	{
		if(*(i->getPoint()) - p < i->getAcc() + acc)
		{
			nameptr.str("");
			nameptr << "Merging new event with " << *i;
			logThreadMessage(nameptr.str());

			i->update();

			throw EventMergedException("To wydarzenie już istnieje");
		}

		if(free_event_id == -1)
			id = i->getId() >= id ? i->getId() + 1 : id;
	}

	logThreadMessage("No matching events");

	free_event_id = -1;

	if(id == -1)
		id = 0;

	nameptr.str("");

	nameptr << "ptrp" << id;
	nameobj << "objp" << id;

	ptime_shared_ptr& time = *seg->construct<ptime_shared_ptr>(boost::interprocess::anonymous_instance)(seg->construct<boost::posix_time::ptime>(boost::interprocess::anonymous_instance)(boost::posix_time::second_clock::local_time()),
			void_allocator_type(seg->get_segment_manager()), ptime_deleter_type(seg->get_segment_manager()));

	point_shared_ptr& pt = *seg->construct<point_shared_ptr>(nameptr.str().c_str())(seg->construct<Point>(nameobj.str().c_str())(lo, la),
			void_allocator_type(seg->get_segment_manager()), point_deleter_type(seg->get_segment_manager()));

	nameobj.str("");
	nameptr.str("");

	nameptr << "ptre";
	nameobj << "obje" << id;

	event_shared_ptr& shared_ptr_instance = *seg->construct<event_shared_ptr>(nameptr.str().c_str())(
			seg->construct<Event>(nameobj.str().c_str())(id, pt, type, acc, time), void_allocator_type(seg->get_segment_manager()),
			event_deleter_type(seg->get_segment_manager()));

	nameptr.str("");

	nameptr << "Creating new event: ID: " << id << " (" << lo << ", " << la << ")";
	logThreadMessage(nameptr.str());

	events->push_back(shared_ptr_instance);

	seg->destroy_ptr(&pt);
	seg->destroy_ptr(&shared_ptr_instance);
	seg->destroy_ptr(&time);

	logThreadMessage("Unlocking events mutex");
}

user_shared_ptr& DataBridge::getUser(long long id)
{
	for(user_shared_ptr& ui : *users)
		if(ui->getId() == id)
			return ui;

	throw BadUserIDException("Użytkownik o podanym ID nie istnieje w systemie");
}

void DataBridge::deleteEvent()
{
	logThreadMessage("Locking events mutex");
	boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*events_mutex);

	logThreadMessage("Locked");

	if(events->size() == 0)
		return;

	std::stringstream nameptr;

	event_shared_ptr& shared_ptr_instance = events->back();

	nameptr << "Removing event ID: " << shared_ptr_instance->getId();
	logThreadMessage(nameptr.str());

	events->pop_back();

	free_event_id = shared_ptr_instance->getId();

	seg->destroy_ptr(&(*shared_ptr_instance));

	logThreadMessage("Unlocking events mutex");
}

boost::python::list DataBridge::checkTrackCollision(points_vector* pts)
{
	boost::python::list ret;

	std::stringstream nameptr;

	long double a, b, d, a2, x1, h, y1;

	for(event_shared_ptr& ev : *events)
	{
		point_shared_ptr n = ev->getPoint();

		for(points_vector::iterator it = pts->begin(); it != pts->end(); ++it)//(point_shared_ptr& p : *pts)
		{
			if(it + 1 != pts->end())
			{
				points_vector::iterator itn = it + 1;
				a = ((*it)->getLat() - (*itn)->getLat()) / ((*it)->getLon() - (*itn)->getLon());
				b = ((*itn)->getLat() * (*it)->getLon() - (*itn)->getLon() * (*it)->getLat()) / ((*it)->getLon() - (*itn)->getLon());
				d = fabs(a * n->getLon() - n->getLat() + b);

				a2 = -1 / a, h = n->getLat() - a2 * n->getLon();
				x1 = (h - b) / (a - a2), y1 = a * x1 + b;

				Point pp(x1, y1);

				if(*n - pp <= ev->getAcc())
				{
					long double lx = getLowerCoordinate((*it)->getLon(), (*itn)->getLon());
					long double hx = getHigherCoordinate((*it)->getLon(), (*itn)->getLon());

					long double ly = getLowerCoordinate((*it)->getLat(), (*itn)->getLat());
					long double hy = getHigherCoordinate((*it)->getLat(), (*itn)->getLat());

					if(pp.getLon() >= lx && pp.getLon() <= hx)
						if(pp.getLat() >= ly && pp.getLat() <= hy)
						{
							boost::python::dict d;
							d["x"] = n->getLon();
							d["y"] = n->getLat();
							d["type"] = ev->getType();
							d["acc"] = ev->getAcc();

							ret.append<boost::python::dict>(d);

							break;
						}
				}
			}
			else
				if(*n - **it <= ev->getAcc())
				{
					boost::python::dict d;
					d["x"] = n->getLon();
					d["y"] = n->getLat();
					d["type"] = ev->getType();
					d["acc"] = ev->getAcc();

					ret.append<boost::python::dict>(d);

					break;
				}
		}
	}

	return ret;
}

void DataBridge::newTrack(long long uid, boost::python::list l)
{
	std::stringstream strd, nameobj;
	boost::python::list ret;

	user_shared_ptr& ui = getUser(uid);

		logThreadMessage("Locking users mutex");
		boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loc(*users_mutex);

		boost::shared_ptr<boost::interprocess::vector<point_shared_ptr> > pts(new boost::interprocess::vector<point_shared_ptr>());

		for(boost::python::ssize_t i = 0; i < boost::python::len(l); ++i)
		{
			boost::python::dict point_dct = boost::python::extract<boost::python::dict>(l[i]);

			long double lo = boost::python::extract<double>(point_dct["lo"]);
			long double la = boost::python::extract<double>(point_dct["la"]);

			point_shared_ptr& pt = *seg->construct<point_shared_ptr>(boost::interprocess::anonymous_instance)(seg->construct<Point>(boost::interprocess::anonymous_instance)(lo, la),
					void_allocator_type(seg->get_segment_manager()), point_deleter_type(seg->get_segment_manager()));

			pts->push_back(pt);

			seg->destroy_ptr(&pt);
		}

		ui->setRoute(seg,*pts);

		logThreadMessage("Unlocking users mutex");

}

boost::python::list DataBridge::pollTrackEvents(long long uid)
{
	boost::python::list ret;
	logThreadMessage("Locking users mutex");
	boost::interprocess::scoped_lock<boost::interprocess::named_mutex> locu(*users_mutex);

	user_shared_ptr& ui = getUser(uid);

	ui->update();

	points_vector* pts = &(ui->getRoute(seg));

	if(pts == NULL)
		throw NullPointerRouteException("Użytkownik o podanym ID nie wybrał trasy");

	logThreadMessage("Locking events");
	boost::interprocess::scoped_lock<boost::interprocess::named_mutex> loce(*events_mutex);

	ret = checkTrackCollision(pts);

	logThreadMessage("Unlocking events mutex");
	logThreadMessage("Unlocking users mutex");

	return ret;
}
