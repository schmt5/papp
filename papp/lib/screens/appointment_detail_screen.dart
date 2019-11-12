import 'package:flutter/material.dart';

import '../models/appointment_model.dart';
import '../models/appointment_type.dart';
import '../models/therapy_model.dart';
import '../models/private_appointment_model.dart';
import '../models/exercise_model.dart';
import '../widgets/therapy_details.dart';
import '../widgets/private_appointment_details.dart';
import '../widgets/exercise_details.dart';

class AppointmentDetailScreen extends StatelessWidget {
  static const routeName = '/appointment-detail';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    var item;
    Widget detailWidget;
    print(args);
    

    if (args['type'] == AppointmentType.Therapie) {
      item = args['item'] as TherapyModel;
      detailWidget = TherapyDetails(item);
    } else if (args['type'] == AppointmentType.Private) {
      
      item = args['item'] as PrivateAppointmentModel;
      detailWidget = PrivateAppointmentDetails(item);
    } else if (args['type'] == AppointmentType.Exercise) {
      item = args['item'] as ExerciseModel;
      detailWidget = ExerciseDetails(item);
    } else {
      // should not be the case
      item = args['item'] as AppointmentModel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Termin Details'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text(
          'Papp-Taler sammeln',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {},
      ),
      body: detailWidget,
    );
  }
}
