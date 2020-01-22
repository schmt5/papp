import 'package:flutter/material.dart';

import '../models/reward_model.dart';
import '../models/reward_type.dart';

class GetRewardScreen extends StatelessWidget {
  static const routeName = 'get-reward';

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
    int choosenReward = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Deine Belohnung'),
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    rewards[choosenReward].imgUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black87,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Text(
                      rewards[choosenReward].title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  bottom: 30,
                ),
                child: Text(
                  'Löse deine Belohnung in der nächsten Therapie ein.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
