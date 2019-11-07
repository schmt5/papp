import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../models/appointment_model.dart';
import '../models/therapy_model.dart';
import '../models/private_appointment_model.dart';
import '../models/exercise_model.dart';
import '../models/appointment_type.dart';

class CreateAppointmentScreen extends StatefulWidget {
  static const routeName = '/create-appointment';

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _therapieForm = GlobalKey<FormState>();
  final _privateAppointmentForm = GlobalKey<FormState>();
  final _exerciseForm = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<bool> isSelected = [true, false, false];

  AppointmentModel _createdItem;

  var typeOfTherapie = [
    'AOT (alltagsorientiertes Training)',
    'Ergotherapie',
    'Heilpädagogische Früherziehung (HFE)',
    'Heilpädagogisches Reiten',
    'Hippotherapie',
    'Hundetherapie',
    'Koch- und Backgruppe',
    'KreAktiv Schule',
    'KreAktiv Therapie',
    'Logopädie',
    'MTT (medizinische Trainingstherapie)',
    'Neuropsychologie',
    'Physiotherapie',
    'Physiotherapie Wasser',
    'PluSport',
    'Psychologie',
    'Robotik obere Extremitäten',
    'Robotik untere Extremitäten (Andago)',
    'Robotik untere Extremitäten (Erigo)',
    'Robotik untere Extremitäten (Lokomat)',
    'Robotik untere Extremitäten (Rysen)',
    'Schule',
    'Sport',
    'Therapeutische Spielgruppe'
  ];

  List<String> searchItems = [];
  String _selectedTherapie;
  TextEditingController _therapieFieldController = TextEditingController();

  _filterSearchResults(String query) {
    List<String> searchResult = [];
    if (query.isNotEmpty) {
      searchResult = typeOfTherapie
          .where(
            (item) => item.toLowerCase().startsWith(query.toLowerCase()),
          )
          .toList();

      setState(() {
        searchItems.clear();
        searchItems.addAll(searchResult);
      });
    } else {
      setState(() {
        searchItems.clear();
      });
    }
  }

  _setTherapie(String item) {
    searchItems.clear();
    setState(() {
      _therapieFieldController.text = item;
    });
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

  void _saveForm() {
    var isValid;
    if (isSelected[0]) {
      // Therapie Form
      isValid = _therapieForm.currentState.validate();
    } else if (isSelected[1]) {
      // Private Appointment Form
      isValid = _privateAppointmentForm.currentState.validate();
    } else {
      // Exercise Form
      isValid = _exerciseForm.currentState.validate();
    }
    if (!isValid) {
      return;
    }

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

    // create AppointmentModel with id, type and dateTime
    if (isSelected[0]) {
      // Therapy
      _createdItem = TherapyModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Therapie,
        title: null,
        dateTime: dateTime,
      );
    } else if (isSelected[1]) {
      // Private Appointment
      _createdItem = PrivateAppointmentModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Private,
        title: null,
        dateTime: dateTime,
      );
    } else {
      // Exercise
      _createdItem = ExerciseModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Exercise,
        title: null,
        dateTime: dateTime,
      );
    }

    // save Form, this add the other values (category, place, supervisor)
    if (isSelected[0]) {
      _therapieForm.currentState.save();

      // insert createdItem [TherapyModel] into Database
      Provider.of<Appointments>(context, listen: false)
          .addAppointment(_createdItem);
    } else if (isSelected[1]) {
      _privateAppointmentForm.currentState.save();

      // insert createdItem [PrivateAppointmentModel] into Database
      Provider.of<Appointments>(context, listen: false)
          .addAppointment(_createdItem);
    } else {
      _exerciseForm.currentState.save();

      // insert createdItem [ExerciseModel] into Database
      Provider.of<Appointments>(context, listen: false)
          .addAppointment(_createdItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuer Termin'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12),
        child: ListView(
          children: <Widget>[
            Center(
              child: ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Text('Therapie'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Text('Privater Termin'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Text('Übung'),
                  )
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
            if (isSelected[0]) _buildTherapieForm(),
            if (isSelected[1]) _buildPrivateAppointmentForm(),
            if (isSelected[2]) _buildExerciseForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTherapieForm() {
    return Form(
      key: _therapieForm,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              onChanged: (val) {
                _filterSearchResults(val);
              },
              controller: _therapieFieldController,
              decoration: InputDecoration(
                  labelText: 'Art der Therapie',
                  icon: Icon(
                    Icons.search,
                  )),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Therapie Form muss angegeben werden';
                }
                return null;
              },
              onSaved: (val) {
                _createdItem.title = val;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: searchItems
                    .map((item) => InkWell(
                          onTap: () {
                            _setTherapie(item);
                          },
                          child: ListTile(
                            title: Text(item),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          searchItems.isNotEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildDateTimePicker(),
                    Divider(),
                    Text(
                      'optional',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Ort',
                          icon: Icon(
                            Icons.location_on,
                          ),
                        ),
                        onSaved: (val) {
                          _createdItem.place = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Therapeut',
                          icon: Icon(
                            Icons.person,
                          ),
                        ),
                        onSaved: (val) {
                          _createdItem = TherapyModel(
                            id: _createdItem.id,
                            type: _createdItem.type,
                            title: _createdItem.title,
                            dateTime: _createdItem.dateTime,
                            duration: _createdItem.duration,
                            place: _createdItem.place,
                            subject: _createdItem.subject,
                            earnedPappTaler: null,
                            supervisor: val,
                          );
                        },
                      ),
                    ),
                    _buildSaveButton(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildPrivateAppointmentForm() {
    return Form(
      key: _privateAppointmentForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Titel des Privaten Termin',
                  icon: Icon(Icons.title)),
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
    );
  }

  Widget _buildExerciseForm() {
    return Form(
      key: _exerciseForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
