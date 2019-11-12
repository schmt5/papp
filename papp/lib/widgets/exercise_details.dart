import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/exercise_model.dart';

class ExerciseDetails extends StatelessWidget {
  final ExerciseModel item;

  ExerciseDetails(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.category),
          title: Text(item.title),
          subtitle: Text('Therapieform'),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text(
            DateFormat.MEd('de_CH').format(item.dateTime),
          ),
          subtitle: Text('Datum'),
        ),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text(DateFormat.Hm('de_CH').format(item.dateTime) + ' Uhr'),
          subtitle: Text('Uhrzeit'),
        ),
        item.place == null
            ? Container()
            : ListTile(
                leading: Icon(Icons.location_on),
                title: Text(item.place),
                subtitle: Text('Ort'),
              ),
      ],
    );
  }
}
