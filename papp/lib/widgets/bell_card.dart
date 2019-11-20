import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../screens/user_screen.dart';

class BellCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(UserScreen.routeName);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListTile(
            leading: Icon(
              Icons.notifications,
              size: 30,
            ),
            title: Consumer<Points>(
              builder: (context, pointData, _) {
                return Text('${pointData.daysLeft} Tage');
              },
            ),
            subtitle: Text('bis du die Glocke läuten darfst.'),
          ),
        ),
      ),
    );
  }
}
