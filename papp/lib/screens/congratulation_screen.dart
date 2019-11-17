import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../screens/home_screen.dart';

class CongratulationScreen extends StatelessWidget {
  static const routeName = '/congratulation';

  @override
  Widget build(BuildContext context) {
    int taler = ModalRoute.of(context).settings.arguments as int;
    int xp = taler * 10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gratulation'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Belohnung annehmen',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          var points = Provider.of<Points>(context, listen: false);
          points.setPappTaler(taler);
          points.setXp(xp);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        },
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Deine Belohnung:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                '$taler',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              subtitle: Text(
                'Papp-Taler',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CircleAvatar(
                child: Icon(Icons.attach_money),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                '$xp',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              subtitle: Text(
                'Erfahrungspunkte',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CircleAvatar(
                child: Text('XP'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
