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
            color: Colors.amber,
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.amber,
                  child: ListTile(
                    leading: Icon(Icons.cake),
                    title: Text(
                      'Wähle deine Belohnung aus',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
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
