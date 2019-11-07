import 'package:flutter/material.dart';

import '../models/reward_model.dart';
import '../widgets/reward_item.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

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
      appBar: AppBar(
        title: Text('Belohnungen'),
      ),
      body: ListView(
        children: rewards
            .map(
              (item) => RewardItem(item.title, item.imgUrl, item.infos),
            )
            .toList(),
      ),
    );
  }
}
