import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../screens/teddy_screen.dart';

class TeddyCard extends StatelessWidget {
  final int level = 1;
  final int xp = 50;
  final double percentOfNextLevel = 0.3;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(TeddyScreen.routeName);
          },
          child: Consumer<Points>(
            builder: (context, pointData, _) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.pets,
                      size: 30,
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(
                          'Teddy',
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Container(
                          child: Text(
                            'lvl: ${pointData.level}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    subtitle: Text('${pointData.xp} Erfahrungspunkte'),
                    title: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Row(
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: constraints.maxWidth *
                                  pointData.percentOfNextLevel,
                              color: Colors.amber[300],
                            ),
                            Container(
                              height: 20,
                              width: constraints.maxWidth *
                                  (1 - pointData.percentOfNextLevel),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.amber[300],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
