import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../screens/reward_screen.dart';

class NoRewardChoosenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var choosenReward = Provider.of<Points>(context).choosenReward;
    var isRewardChoosen = choosenReward != null;

    return isRewardChoosen
        ? Container()
        : Card(
            margin: EdgeInsets.all(15),
            color: Colors.amber,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('Noch keine Belohnung ausgwählt'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.teal[800],
                        width: 2,
                      ),
                      child: Text(
                        'Belohnung auswählen',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RewardScreen.routeName);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
