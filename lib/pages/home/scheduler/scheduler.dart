import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/create_schedule.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_form.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class Scheduler extends StatefulWidget {
  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  final _calendarController = CalendarController();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildCard({Event event}) {
    return Card(
      elevation: 2.0,
      shadowColor: Colors.grey,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.notifications,
              color: Colors.purple,
            ),
          ),
          Container(
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
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  event.startEnd,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvents() {
    final children = <Widget>[];
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 2, 6, 0),
            child: Column(
              children: children.isEmpty? children :
                  <Widget>[
                    Text(
                      'Nothing to show',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    )
                  ],
            ),
          ),
        ),
      ),
    );
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
          onPressed: () {
            // TODO: Implement Urgent Items
          },
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
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: _buildTitle(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
          child: TableCalendar(
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
              size: 40,
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
}
