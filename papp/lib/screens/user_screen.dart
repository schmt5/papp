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
                      width: 120,
                      child: Text(
                        'Mein Profil',
                        textAlign: TextAlign.center,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                '${pointData.pappTaler}',
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
