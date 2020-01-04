import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/appointments.dart';

class StatisticScreen extends StatelessWidget {
  static const routeName = '/statistic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fortschritt'),
      ),
      body: Consumer<Appointments>(
        builder: (context, itemData, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Verdiente Papp-Taler im Durchschnitt:',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        itemData.averageScore.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
