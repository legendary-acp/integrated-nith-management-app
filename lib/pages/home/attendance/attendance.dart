import 'package:flutter/material.dart';
import 'package:integratednithmanagementapp/model/subject_model.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/pages/home/attendance/attendace_chart.dart';
import 'package:integratednithmanagementapp/services/database.dart';
import 'package:provider/provider.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key key, @required this.database}) : super(key: key);

  final Database database;

  static Widget show(BuildContext context) {
    Database database = Provider.of<Database>(context);
    return Attendance(database: database);
  }

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String rollNo;

  List<Subject> subjects = [];

  List<Widget> children = List<Widget>();

  Widget _buildDetailsCard({int attendance, int total, String name}) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.47),
      height: (MediaQuery.of(context).size.height * 0.145),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'libre_baskerville',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$attendance/$total',
                    style: TextStyle(
                      fontFamily: 'libre_baskerville',
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: (MediaQuery.of(context).size.height / 20)),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Attendance',
              style: TextStyle(
                fontFamily: 'libre_baskerville',
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        StreamBuilder<UserDetails>(
          stream: widget.database.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              rollNo = snapshot.data.rollNo;
              return StreamBuilder(
                stream: widget.database.subjectAttendanceStream(
                    rollNo: rollNo), //TODO: Change this
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    subjects = snapshot.data;
                    for (int i = 0; i < subjects.length; i++) {
                      children.add(_buildDetailsCard(
                        attendance: subjects[i].attendance,
                        total: subjects[i].total,
                        name: subjects[i].name,
                      ));
                    }
                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: AttendanceChart(
                            subjects: subjects,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Details',
                              style: TextStyle(
                                fontFamily: 'libre_baskerville',
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height * 0.365),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Wrap(
                                  children: children,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else
                    return CircularProgressIndicator();
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
