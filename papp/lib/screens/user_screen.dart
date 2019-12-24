import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../models/reward_model.dart';
import '../models/reward_type.dart';
import '../widgets/papp_taler_card.dart';
import '../widgets/bell_card.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  final int selectedReward = 1;
  final int daysLeft = 64;

  var rewards = [
    RewardModel(
        'Alpamare', RewardType.Alpamare, 'assets/images/alpamare.jpg', 'nice'),
    RewardModel('Zoo Zürich', RewardType.ZooZurich,
        'assets/images/zoo_zurich.jpeg', 'kuul'),
    RewardModel('Technorama', RewardType.Technorama,
        'assets/images/technorama.jpg', 'kuul'),
    RewardModel(
        'Europapark',
        RewardType.Europapark,
        'assets/images/europapark.jpg',
        'Europapark ist ein Erlebnispark in Deutschland. Dort kannst du fein essen, Shows anschauen und Achterbahnfahren'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Points>(context).fetchAndSetPoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  snap: false,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Mein Profil',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    background: Consumer<Points>(
                      builder: (context, pointData, _) {
                        return pointData.choosenReward != null
                            ? Image.asset(
                                rewards[pointData.choosenReward].imgUrl,
                                fit: BoxFit.cover,
                              )
                            : Container();
                      },
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: Consumer<Points>(
                    builder: (context, pointData, _) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                '${pointData.pappTaler} von 50',
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
                              trailing: Container(
                                height: 75,
                                width: 75,
                                child: Image.asset(
                                  'assets/images/papp_taler.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                '${pointData.daysLeft}',
                                style: TextStyle(
                                  fontSize: 36,
                                ),
                              ),
                              subtitle: Text(
                                'Tage, bist du die Glocke läuten darfst.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: CircleAvatar(
                                child: Icon(Icons.notifications),
                              ),
                            ),
                          ),
                          //PappTalerCard(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 8, right: 8),
                            child: RaisedButton.icon(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child: pointData.xp < 50
                                    ? Text(
                                        'Papp-Taler einlösen (Dir fehlen noch ${50 - pointData.pappTaler} Papp-Taler)',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        'Papp-Taler einlösen',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                              icon: Icon(
                                Icons.cake,
                                color: Colors.black,
                              ),
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              onPressed:
                                  pointData.pappTaler < 50 ? null : () {},
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
