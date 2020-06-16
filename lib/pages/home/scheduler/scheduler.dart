import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/urgent_events.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/create_schedule.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_form.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_manager.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:integratednithmanagementapp/shared/constants.dart';

class Scheduler extends StatefulWidget {
  Scheduler({@required this.manager, @required this.database});

  final EventManager manager;
  final Database database;

  static Widget create(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);
    return Provider<EventManager>(
      create: (context) => EventManager(database: database),
      child: Consumer<EventManager>(
        builder: (context, manager, _) => Scheduler(
          manager: manager,
          database: database,
        ),
      ),
    );
  }

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  final _calendarController = CalendarController();
  String currentDate = DateTime.now().toIso8601String().substring(0, 10);

  void _onDateChanged(DateTime dateTime) {
    setState(() {
      currentDate = dateTime.toIso8601String().substring(0, 10);
    });
  }


  void _markAsDone(Event event) {
    widget.manager.markEventAsDone(event);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildCard({Event event}) {
    return Dismissible(
      key: Key(event.id),
      onDismissed: (direction) {
        widget.manager.deleteEvent(event);
      },
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        shadowColor: Colors.grey,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                typeIcon[event.type],
                color: Colors.grey,
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 75),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    event.type,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      event.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        event.startEnd,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        icon: event.done
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onPressed: () => _markAsDone(event),
                        color: event.done ? Colors.blue : Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvents() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: StreamBuilder<List<Event>>(
            stream: widget.database.eventStream(date: currentDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        _buildCard(event: snapshot.data[index]),
                  );
                } else {
                  return Align(
                    child: Text(
                      'Nothing to show',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    ),
                  );
                }
              } else
                return Align(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ),
    );

    /*return Expanded(
      child:
    );*/
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: '${DateFormat.yMMMMd('en_US').format(DateTime.now())} ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    fontFamily: 'libre_baskerville',
                  ),
                ),
                TextSpan(
                  text: '${DateFormat('EEE').format(DateTime.now())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontFamily: 'libre_baskerville',
                  ),
                )
              ]),
        ),
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.hourglass_empty,
            color: Colors.indigo,
          ),
          onPressed: () => _urgentEvents(context),
        )
      ],
    );
  }

  Widget _build() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 35.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
          child: _buildTitle(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
          child: TableCalendar(
            onDaySelected: (day, list) => _onDateChanged(day),
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.week,
            availableCalendarFormats: const {CalendarFormat.week: 'Week'},
          ),
        ),
        _buildEvents(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _build(),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () => addEvent(context),
          ),
        ),
      ],
    );
  }

  addEvent(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);
    EventManager eventManager = EventManager(database: database);
    EventForm eventForm = EventForm(manager: eventManager);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CreateSchedule(
                eventForm: eventForm,
              )),
    );
  }

  _urgentEvents(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);
    EventManager eventManager = EventManager(database: database);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => UrgentEvents(
            database: database,
            manager: eventManager,
          )),
    );
  }
  
}
