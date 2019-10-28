import 'package:flutter/material.dart';

class BellCard extends StatelessWidget {
  final int daysLeft = 64;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListTile(
            leading: Icon(
              Icons.notifications,
              size: 36.0,
            ),
            title: Text('$daysLeft Tage'),
            subtitle: Text('bis du die Glocke läuten darfst.'),
          ),
        ),
      ),
    );
  }
}
