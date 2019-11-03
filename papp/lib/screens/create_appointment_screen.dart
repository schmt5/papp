import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../models/appointment_model.dart';

class CreateAppointmentScreen extends StatefulWidget {
  static const routeName = '/create-appointment';

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _form = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _selectTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuer Termin'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text('Speichern'),
        onPressed: () {
          var year = _selectedDate.year;
          var month = _selectedDate.month;
          var day = _selectedDate.day;
          var hour = _selectedTime.hour;
          var minute = _selectedTime.minute;
          var second = _selectedDate.second;
          var millisecond = _selectedDate.millisecond;

          var dateTime = DateTime(year, month, day, hour, minute, second, millisecond);

          var appointment = AppointmentModel(
            id: dateTime.millisecondsSinceEpoch,
            category: "Physiotherapie",
            dateTime: dateTime,
          );
          Provider.of<Appointments>(context, listen: false)
              .addAppointment(appointment);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Art der Therapie'),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: _selectedDate == null
                    ? Text(
                        'Tag wählen...',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    : Text(DateFormat.MMMEd('de_CH').format(_selectedDate)),
                trailing: RaisedButton(
                  child: Text(
                    'wählen',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _selectDate,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: _selectedTime == null
                    ? Text(
                        'Uhrzeit wählen...',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    : Text('${_selectedTime.hour}:${_selectedTime.minute} Uhr'),
                trailing: RaisedButton(
                  child: Text(
                    'wählen',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _selectTime,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
