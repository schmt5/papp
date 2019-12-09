import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../models/reward_model.dart';
import '../widgets/reward_item.dart';
import '../models/reward_type.dart';

class RewardScreen extends StatelessWidget {
  static const routeName = '/reward';

  var rewards = [
    RewardModel('Alpamare', RewardType.Alpamare, 'assets/images/alpamare.jpg',
        'Das Alpamare ist ein Erlebnisbad. Es gibt insgesamt 12 Wasser-Rutschbahnen. Weiter gibt es ein Wellen-Bad, ein Sprudel-Bad, ein Freifluss-Bad. Das Wellen-Bad ist drinnen. Alle anderen Bäder sind drausen.'),
    RewardModel(
        'Zoo Zürich',
        RewardType.ZooZurich,
        'assets/images/zoo_zurich.jpeg',
        'Im Zoo Zürich leben 375 verschiedene Tiere. Bei jeder Tier-Art gibt es mindestens ein männliches Tier und ein weibliches Tier. Das Motto von Zoo Zürich ist: "Wer Tiere kennt, wird Tiere schützen".'),
    RewardModel(
        'Technorama',
        RewardType.Technorama,
        'assets/images/technorama.jpg',
        'Im Technorama erlebst du die Faszination der Biologie, der Chemie und der Physik. Täglich gibt es Vorführungen.'),
    RewardModel(
        'Europapark',
        RewardType.Europapark,
        'assets/images/europapark.jpg',
        'Europapark ist ein Erlebnispark in Deutschland. Dort kannst du fein essen, Shows anschauen und Achterbahnfahren'),
  ];

  @override
  Widget build(BuildContext context) {
    var choosenReward = Provider.of<Points>(context).choosenReward;
    var isRewardChoosen = choosenReward != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Belohnungen'),
      ),
      body: ListView(
        children: <Widget>[
          isRewardChoosen
              ? Container()
              : Card(
                  margin: EdgeInsets.all(15),
                  color: Colors.amber,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'In deinen Therapien kannst du Papp-Taler sammeln. Die Papp-Taler kannst du gegen eine Belohnung eintauschen.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Wähle jetzt deine Belohnung aus.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Column(
            children: rewards
                .map(
                  (item) => RewardItem(
                      item.title, item.type, item.imgUrl, item.infos),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
