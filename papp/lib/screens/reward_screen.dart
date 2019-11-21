import 'package:flutter/material.dart';

import '../models/reward_model.dart';
import '../widgets/reward_item.dart';
import '../models/reward_type.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

  var rewards = [
    RewardModel('Alpamare', RewardType.Alpamare, 'assets/images/alpamare.jpg', 'nice'),
    RewardModel('Zoo Zürich', RewardType.ZooZurich, 'assets/images/zoo_zurich.jpeg', 'kuul'),
    RewardModel('Technorama', RewardType.Technorama, 'assets/images/technorama.jpg', 'kuul'),
    RewardModel('Europapark', RewardType.Europapark, 'assets/images/europapark.jpg',
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
              (item) => RewardItem(item.title, item.type, item.imgUrl, item.infos),
            )
            .toList(),
      ),
    );
  }
}
