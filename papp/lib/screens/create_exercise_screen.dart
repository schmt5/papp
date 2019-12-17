import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../models/exercise_model.dart';
import '../models/appointment_type.dart';

class CreateExerciseScreen extends StatefulWidget {
  static const routeName = '/create-exercise';

  @override
  _CreateExerciseScreenState createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  final _form = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  ExerciseModel _createdItem;

  void _saveForm() {
    var isValid = _form.currentState.validate();
    if (isValid) {
      // Get values from _selectedDate and _selectedTime
      var year = _selectedDate.year;
      var month = _selectedDate.month;
      var day = _selectedDate.day;
      var hour = _selectedTime.hour;
      var minute = _selectedTime.minute;
      var second = _selectedDate.second;
      var millisecond = _selectedDate.millisecond;

      // create new DateTime including selected Date and selected Time
      // second and millisecond are importent for the id of the appointment.
      var dateTime =
          DateTime(year, month, day, hour, minute, second, millisecond);

      _createdItem = ExerciseModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Exercise,
        title: null,
        dateTime: dateTime,
      );

      // save Form, this add the other values (category, place, supervisor)
      _form.currentState.save();

      // insert createdItem [TherapyModel] into Database
      Provider.of<Appointments>(context, listen: false)
          .addAppointment(_createdItem);

      Navigator.pop(context);
    }
  }

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
        title: Text('Übung Termin erstellen'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Titel der Übung',
                  icon: Icon(Icons.title),
                ),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Titel muss angegeben werden';
                  }
                  return null;
                },
                onSaved: (val) {
                  _createdItem.title = val;
                },
              ),
            ),
            _buildDateTimePicker(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
      child: RaisedButton.icon(
        label: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Text(
            'Speichern',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        icon: Icon(Icons.save),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: _saveForm,
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          FormField(
            validator: (_) {
              if (_selectedDate == null) {
                return 'Datum muss angegeben werden';
              }
              return null;
            },
            builder: (state) => ListTile(
              onTap: _selectDate,
              leading: Icon(Icons.calendar_today),
              title: _selectedDate == null
                  ? Text(
                      'Tag wählen...',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  : Text(
                      DateFormat.MMMEd('de_CH').format(_selectedDate),
                    ),
              subtitle: state.hasError
                  ? Text(state.errorText,
                      style: TextStyle(
                        color: Colors.redAccent[700],
                        fontSize: 12,
                      ))
                  : Container(),
              trailing: RaisedButton(
                child: Text(
                  'wählen',
                ),
                onPressed: _selectDate,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          FormField(
            validator: (_) {
              if (_selectedTime == null) {
                return 'Uhrzeit muss angegeben werden';
              }
              return null;
            },
            builder: (state) => ListTile(
              onTap: _selectTime,
              leading: Icon(Icons.access_time),
              title: _selectedTime == null
                  ? Text(
                      'Uhrzeit wählen...',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  : Text('${_selectedTime.hour}:${_selectedTime.minute} Uhr'),
              subtitle: state.hasError
                  ? Text(
                      state.errorText,
                      style: TextStyle(
                        color: Colors.redAccent[700],
                        fontSize: 12,
                      ),
                    )
                  : Container(),
              trailing: RaisedButton(
                child: Text(
                  'wählen',
                ),
                onPressed: _selectTime,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
