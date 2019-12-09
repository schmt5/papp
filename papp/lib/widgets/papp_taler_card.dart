import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../screens/user_screen.dart';

class PappTalerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(UserScreen.routeName);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    'assets/images/papp_taler.png',
                    fit: BoxFit.contain,
                  ),
                ),
                title: Consumer<Points>(
                  builder: (ctx, pointData, _) {
                    return Text(
                      '${pointData.pappTaler} Papp Taler',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
