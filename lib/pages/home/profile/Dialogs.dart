import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:integratednithmanagementapp/model/user_info_model.dart';
import 'package:integratednithmanagementapp/services/database.dart';

class Dialogs {
  Dialogs(
      {@required this.context,
      @required this.details,
      @required this.database}) {
    this.branch = details.branch;
    this.year = details.year;
    this.hostel = details.hostel;
  }

  final BuildContext context;
  final UserDetails details;
  final Database database;

  String branch;
  String year;
  String hostel;

  List<String> branches = [
    'Architecture',
    'Civil Engineering',
    'CS Engineering',
    'CSE-DD',
    'ECE',
    'ECE-DD',
    'Mech Engineering',
    'Chemical Engineering',
    'Electrical Engineering',
    'Material Science'
  ];

  List<String> years = [
    'First',
    'Second',
    'Third',
    'Final',
    'Super Final',
  ];

  List<String> hostels = [
    'Aravali',
    'KBH',
    'VBH',
    'MMH',
    'Satpura',
    'Shivalik',
    'DBH',
    'NBH',
    'Himgiri',
    'Himadri',
    'Udaygiri',
    'AGH',
    'PGH',
  ];

  showDisplayNameDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    initialValue: details.displayName,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Can\'t be empty',
                    onSaved: (value) {
                      details.updateDisplayName(value);
                      database.updateUserInfo(info: details);
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  _formKey.currentState.validate();
                  _formKey.currentState.save();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  showRollNoDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    initialValue: details.rollNo,
                    decoration: InputDecoration(labelText: 'Roll No'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Can\'t be empty',
                    onSaved: (value) {
                      details.updateRollNo(value);
                      database.updateUserInfo(info: details);
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  _formKey.currentState.validate();
                  _formKey.currentState.save();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  showMobileNoDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    initialValue: details.mobileNo,
                    decoration: InputDecoration(labelText: 'Mobile No'),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Can\'t be empty',
                    onSaved: (value) {
                      details.updateMobileNo(value);
                      database.updateUserInfo(info: details);
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  _formKey.currentState.validate();
                  _formKey.currentState.save();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  showBranchDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              child: FormBuilderCustomField(
                attribute: 'Branch',
                initialValue: 'CSE-DD',
                formField: FormField(
                  enabled: true,
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Branch",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                        errorText: field.errorText,
                      ),
                      child: Container(
                        height: 70,
                        child: CupertinoPicker(
                          looping: true,
                          itemExtent: 30,
                          children:
                              branches.map((value) => Text(value)).toList(),
                          onSelectedItemChanged: (index) {
                            details.updateBranch(branches[index]);
                            field.didChange(branches[index]);
                          },
                          scrollController: FixedExtentScrollController(
                              initialItem: branches.indexOf(branch)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  database.updateUserInfo(info: details);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  showYearDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              child: FormBuilderCustomField(
                attribute: 'Year',
                initialValue: 'First',
                formField: FormField(
                  enabled: true,
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Year',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                        errorText: field.errorText,
                      ),
                      child: Container(
                        height: 70,
                        child: CupertinoPicker(
                          looping: true,
                          itemExtent: 30,
                          children: years.map((value) => Text(value)).toList(),
                          onSelectedItemChanged: (index) {
                            details.updateYear(years[index]);
                            field.didChange(years[index]);
                          },
                          scrollController: FixedExtentScrollController(
                              initialItem: years.indexOf(year)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  database.updateUserInfo(info: details);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  showHostelDialog() async {
    final _formKey = GlobalKey<FormState>();
    showDialog<String>(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              child: FormBuilderCustomField(
                attribute: 'Hostel',
                initialValue: 'NBH',
                formField: FormField(
                  enabled: true,
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Hostel',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                        errorText: field.errorText,
                      ),
                      child: Container(
                        height: 70,
                        child: CupertinoPicker(
                          looping: true,
                          itemExtent: 30,
                          children:
                              hostels.map((value) => Text(value)).toList(),
                          onSelectedItemChanged: (index) {
                            details.updateHostel(hostels[index]);
                            field.didChange(hostels[index]);
                          },
                          scrollController: FixedExtentScrollController(
                              initialItem: hostels.indexOf(hostel)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  database.updateUserInfo(info: details);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
