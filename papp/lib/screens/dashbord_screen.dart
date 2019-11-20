import 'package:flutter/material.dart';

import '../widgets/teddy_card.dart';
import '../widgets/bell_card.dart';
import '../widgets/next_appointment_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TeddyCard(),
        BellCard(),
        NextAppointmentCard(),
      ],
    );
  }
}
