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
  final _therapieForm = GlobalKey<FormState>();
  final _privateAppointmentForm = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  List<bool> isSelected = [true, false, false];

  AppointmentModel _createdItem = AppointmentModel(
    id: null,
    category: null,
    dateTime: null,
    place: null,
    supervisor: null,
    subject: null,
    earnedPappTaler: null,
  );

  // for TherapieForm
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
    } else {
      // Private Appointment Form
      isValid = _privateAppointmentForm.currentState.validate();
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

    // create AppointmentModel with id and dateTime
    _createdItem = AppointmentModel(
      id: dateTime.millisecondsSinceEpoch,
      category: null,
      dateTime: dateTime,
    );

    // save Form, this add the other values (category, place, supervisor)
    if (isSelected[0]) {
      _therapieForm.currentState.save();

      // insert createdItem into Database
      Provider.of<Appointments>(context, listen: false)
          .addAppointment(_createdItem);
    } else {
      _privateAppointmentForm.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuer Termin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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
                    child: Text('Aktivität'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Text('Privater Termin'),
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
            isSelected[0]
                ? _buildTherapieForm()
                : _buildPrivateAppointmentForm(),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: RaisedButton.icon(
                label: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Text('Speichern'),
                ),
                icon: Icon(Icons.save),
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: _saveForm,
              ),
            )
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
          TextFormField(
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
              _createdItem = AppointmentModel(
                id: _createdItem.id,
                category: val,
                dateTime: _createdItem.dateTime,
                place: _createdItem.place,
                subject: _createdItem.subject,
                supervisor: _createdItem.supervisor,
                earnedPappTaler: _createdItem.earnedPappTaler,
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          Container(
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
          FormField(
            validator: (_) {
              if (_selectedDate == null) {
                return 'Datum muss ausgewählt werden';
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
                onPressed: _selectDate,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          FormField(
            validator: (_) {
              if (_selectedTime == null) {
                return 'Tag muss ausgewählt werden';
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
                      style:
                          TextStyle(color: Colors.redAccent[700], fontSize: 12),
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
          Divider(),
          Text(
            'optional',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Ort',
              icon: Icon(
                Icons.location_on,
              ),
            ),
            onSaved: (val) {
              _createdItem = AppointmentModel(
                id: _createdItem.id,
                category: _createdItem.category,
                dateTime: _createdItem.dateTime,
                place: val,
                subject: _createdItem.subject,
                supervisor: _createdItem.supervisor,
                earnedPappTaler: _createdItem.earnedPappTaler,
              );
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Therapeut',
              icon: Icon(
                Icons.person,
              ),
            ),
            onSaved: (val) {
              _createdItem = AppointmentModel(
                id: _createdItem.id,
                category: _createdItem.category,
                dateTime: _createdItem.dateTime,
                place: _createdItem.place,
                subject: _createdItem.subject,
                supervisor: val,
                earnedPappTaler: _createdItem.earnedPappTaler,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivateAppointmentForm() {
    return Form(
      key: _privateAppointmentForm,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Titel',
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Titel muss angegeben werden';
              }
              return null;
            },
          ),
          SizedBox(
            height: 16,
          ),
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
