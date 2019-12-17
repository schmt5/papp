import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';
import '../models/therapy_model.dart';
import '../models/appointment_type.dart';

class CreateTherapyScreen extends StatefulWidget {
  static const routeName = '/create-therapy';

  @override
  _CreateTherapyScreenState createState() => _CreateTherapyScreenState();
}

class _CreateTherapyScreenState extends State<CreateTherapyScreen> {
  final _form = GlobalKey<FormState>();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  TherapyModel _createdItem;

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

      _createdItem = TherapyModel(
        id: dateTime.millisecondsSinceEpoch,
        type: AppointmentType.Therapie,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapie Termin erstellen'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
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
                        'freiwillig',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Ort (freiwillig)',
                            icon: Icon(
                              Icons.location_on,
                            ),
                          ),
                          onSaved: (val) {
                            if (val.isNotEmpty) {
                              _createdItem.place = val;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Therapeut (freiwillig)',
                            icon: Icon(
                              Icons.person,
                            ),
                          ),
                          onSaved: (val) {
                            if (val.isNotEmpty) {
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
                            }
                          },
                        ),
                      ),
                      _buildSaveButton(),
                    ],
                  ),
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
              trailing: FlatButton(
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
              trailing: FlatButton(
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
