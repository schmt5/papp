import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NextAppointmentCard extends StatelessWidget {
  final String category = 'Ergotherapie';
  final DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 25,
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  'Nächster Termin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.category),
                  SizedBox(
                    width: 5,
                  ),
                  Text(category),
                  Spacer(),
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 5,
                  ),
                  Text(DateFormat.MMMEd().format(dateTime)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
