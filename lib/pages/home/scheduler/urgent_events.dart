import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:integratednithmanagementapp/services/database.dart';
import 'package:integratednithmanagementapp/model/event_model.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_manager.dart';
import 'package:integratednithmanagementapp/shared/constants.dart';

class UrgentEvents extends StatefulWidget {
  UrgentEvents({Key key, @required this.database, @required this.manager})
      : super(key: key);

  final Database database;
  final EventManager manager;

  @override
  _UrgentEventsState createState() => _UrgentEventsState();
}

class _UrgentEventsState extends State<UrgentEvents> {
  void _markAsDone(Event event) {
    widget.manager.markEventAsDone(event);
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

  _buildList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
          child: Text(
            'Urgent Events',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.height - 103),
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: StreamBuilder<List<Event>>(
              stream: widget.database.urgentEventStream(),
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
                        'No Urgent Event',
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildList(),
          Positioned(
            right: 5,
            top: 30,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
