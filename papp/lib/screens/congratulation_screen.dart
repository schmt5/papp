import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 280,
              child: FlareActor(
                'assets/teddy.flr',
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                animation: 'successDelay',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Deine Belohnung:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildNextLevelWidget(context, xp), // if nextLevel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
            SizedBox(
              height: 80,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8, bottom: 16),
            //   child: RaisedButton(
            //     color: Theme.of(context).accentColor,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //         vertical: 8,
            //         horizontal: 16,
            //       ),
            //       child: Text(
            //         'Belohnung annehmen',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //     onPressed: () {
            //       var points = Provider.of<Points>(context, listen: false);
            //       points.setPappTaler(taler);
            //       points.setXp(xp);
            //       Navigator.of(context)
            //           .pushReplacementNamed(HomeScreen.routeName);
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildNextLevelWidget(BuildContext context, int xp) {
    return Provider.of<Points>(context, listen: false).gonnaBeNextLevel(xp)
        ? Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '🎉🎉🎉🎉',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Level Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        '🎉🎉🎉🎉',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: Consumer<Points>(
                      builder: (context, pointData, _) {
                        return Text(
                          '${pointData.level + 1}',
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
