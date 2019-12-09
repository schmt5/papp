import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../widgets/teddy_card.dart';
import '../widgets/bell_card.dart';
import '../widgets/next_appointment_card.dart';
import '../widgets/no_reward_choosen_card.dart';
import '../widgets/papp_taler_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Points>(context, listen: false).fetchAndSetPoints(),
      builder: (context, snapshot) {
        return ListView(
          children: <Widget>[
            NoRewardChoosenCard(),
            TeddyCard(),
            PappTalerCard(),
            //BellCard(),
            NextAppointmentCard(),
          ],
        );
      },
    );
  }
}
