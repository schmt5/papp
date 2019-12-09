import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../widgets/teddy.dart';

class TeddyScreen extends StatelessWidget {
  static const routeName = '/teddy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Teddy'),
        ),
        body: FutureBuilder(
          future: Provider.of<Points>(context).fetchAndSetPoints(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Teddy(),
                        ),
                      ),
                    ),
                    Consumer<Points>(
                      builder: (context, pointData, _) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  '${pointData.level}',
                                  style: TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                                subtitle: Text(
                                  'Level',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: CircleAvatar(
                                  child: Text('lvl'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              child: ListTile(
                                title: Text(
                                  '${pointData.xp}',
                                  style: TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                                // subtitle: Text(
                                //   'Erfahrungspunkte',
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: Theme.of(context).primaryColor,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                trailing: CircleAvatar(
                                  child: Text('EP'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: ListTile(
                                subtitle: Text(
                                  '${pointData.xpForNextLevel - pointData.xp} Erfahrungspunkte, bis zum nächsten Level',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                title: LayoutBuilder(
                                  builder: (ctx, constraints) {
                                    return Row(
                                      children: <Widget>[
                                        Container(
                                          height: 30,
                                          width: constraints.maxWidth *
                                              pointData.percentOfNextLevel,
                                          color: Colors.amber[300],
                                        ),
                                        Container(
                                          height: 30,
                                          width: constraints.maxWidth *
                                              (1 -
                                                  pointData.percentOfNextLevel),
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
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
