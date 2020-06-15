import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// TODO: For rich text field
import 'package:zefyr/zefyr.dart';

import 'package:integratednithmanagementapp/custom_widget/custom_button.dart';
import 'package:integratednithmanagementapp/pages/home/scheduler/event_form.dart';


// ignore: must_be_immutable
class CreateSchedule extends StatefulWidget {
  CreateSchedule({@required this.eventForm});

  final EventForm eventForm;

  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'Title',
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (value) =>
                    widget.eventForm.updateEventDetails(title: value),
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                attribute: 'Description',
                maxLines: 2,
                onChanged: (value) =>
                    widget.eventForm.updateEventDetails(description: value),
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderCustomField(
                attribute: 'Type',
                initialValue: 'Class',
                validators: [
                  FormBuilderValidators.required(),
                ],
                formField: FormField(
                  enabled: true,
                  builder: (FormFieldState<dynamic> field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Type",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        border: InputBorder.none,
                        errorText: field.errorText,
                      ),
                      child: Container(
                        height: 50,
                        child: CupertinoPicker(
                          itemExtent: 30,
                          children: widget.eventForm.eventTypes
                              .map((c) => Text(c))
                              .toList(),
                          onSelectedItemChanged: (index) {
                            widget.eventForm.updateEventDetails(
                                type: widget.eventForm.eventTypes[index]);
                            field.didChange(widget.eventForm.eventTypes[index]);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderSwitch(
                activeColor: Colors.deepPurple,
                label: Text(
                  'Urgent',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                attribute: "urgent",
                initialValue: false,
                onChanged: (value) =>
                    widget.eventForm.updateEventDetails(urgent: value),
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderDateTimePicker(
                inputType: InputType.time,
                attribute: 'startTime',
                decoration: InputDecoration(labelText: 'Start Time'),
                onChanged: widget.eventForm.updateStartTime,
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderDateTimePicker(
                inputType: InputType.time,
                attribute: 'endTime',
                decoration: InputDecoration(labelText: 'End Time'),
                onChanged: widget.eventForm.updateEndTime,
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderDateTimePicker(
                inputType: InputType.date,
                attribute: 'date',
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: widget.eventForm.updateDate,
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'Submit',
                bgColor: Colors.deepPurple,
                pressed: () => widget.eventForm.submit(context),
                elevation: 2.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Text(
                    'Create Event',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _buildForm(context),
              ],
            ),
          ),
          Positioned(
              top: 35,
              right: 15,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 35,
                ),
                onPressed: exit,
              ))
        ],
      ),
    );
  }

  exit() {
    Navigator.pop(context);
  }
}
