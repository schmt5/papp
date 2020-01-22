import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

import '../models/appointment_model.dart';
import '../models/appointment_type.dart';
import '../models/therapy_model.dart';
import '../models/private_appointment_model.dart';
import '../models/exercise_model.dart';
import '../widgets/therapy_details.dart';
import '../widgets/private_appointment_details.dart';
import '../widgets/exercise_details.dart';
import '../screens/congratulation_screen.dart';

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
      floatingActionButton: item.type == AppointmentType.Therapie
          ? FloatingActionButton.extended(
              icon: Icon(Icons.camera_alt),
              label: Text(
                'Papp-Taler sammeln',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => _scan(context, item.id),
            )
          : null,
      body: detailWidget,
    );
  }

  _scan(BuildContext ctx, int id) async {
    var args = [3, id];
    Navigator.of(ctx).pushNamed(CongratulationScreen.routeName, arguments: args);

    // comment for presi
    // const int securityKey = 199722369;
    // var scannedCode = await BarcodeScanner.scan();

    // try {
    //   int key = int.parse(scannedCode.split('.').first);
    //   int taler = int.parse(scannedCode.split('.').last);

    //   if (key == securityKey && taler >= 0 && taler <= 3) {
    //     var args = [taler, id];
    //     Navigator.of(ctx).pushNamed(
    //       CongratulationScreen.routeName,
    //       arguments: args,
    //     );
    //   } else {
    //     return showDialog(
    //       context: ctx,
    //       builder: (ctx) => AlertDialog(
    //         title: Text(
    //           'Falscher QR Code',
    //         ),
    //         content: Center(
    //           child: Text('Es scheint, als wäre dies kein korrekter QR Code.'),
    //         ),
    //         actions: <Widget>[
    //           RaisedButton(
    //             child: Text(
    //               'Verstanden',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () {
    //               Navigator.of(ctx).pop();
    //             },
    //           )
    //         ],
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   return showDialog(
    //     context: ctx,
    //     builder: (ctx) => AlertDialog(
    //       title: Text('Falscher QR Code'),
    //       content: Center(
    //         child: Container(
    //           height: 100,
    //           child: Text('Es scheint, als wäre dies kein korrekter QR Code.'),
    //         ),
    //       ),
    //       actions: <Widget>[
    //         RaisedButton(
    //           child: Text(
    //             'Verstanden',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //           onPressed: () {
    //             Navigator.of(ctx).pop();
    //           },
    //         )
    //       ],
    //     ),
    //   );
    // }
  }
}
