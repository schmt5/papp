import 'package:flutter/material.dart';

import '../models/reward_model.dart';
import '../widgets/papp_taler_card.dart';
import '../widgets/bell_card.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';

  final int selectedReward = 1;
  final int daysLeft = 64;

  var rewards = [
    RewardModel('Alpamare', 'assets/images/alpamare.jpg', 'nice'),
    RewardModel('Zoo Zürich', 'assets/images/zoo_zurich.jpeg', 'kuul'),
    RewardModel('Technorama', 'assets/images/technorama.jpg', 'kuul'),
    RewardModel('Europapark', 'assets/images/europapark.jpg',
        'Europapark ist ein Erlebnispark in Deutschland. Dort kannst du fein essen, Shows anschauen und Achterbahnfahren'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              background: Image.asset(
                rewards[selectedReward].imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                PappTalerCard(),
                Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                      title: Text('$daysLeft Tage'),
                      subtitle: Text('bis du die Glocke läuten darfst.'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
