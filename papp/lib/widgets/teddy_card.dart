import 'package:flutter/material.dart';

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
        child: ListTile(
          leading: Icon(
            Icons.pets,
            size: 36.0,
          ),
          title: Row(
            children: <Widget>[
              Text('Level: $level'),
              SizedBox(
                width: 10,
              ),
              Text('XP: $xp')
            ],
          ),
          subtitle: LayoutBuilder(
            builder: (ctx, constraints) {
              return Row(
                children: <Widget>[
                  Container(
                    height: 15,
                    width: constraints.maxWidth * percentOfNextLevel,
                    color: Colors.amber[300],
                  ),
                  Container(
                    height: 15,
                    width: constraints.maxWidth * (1 - percentOfNextLevel),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 2.0,
                      color: Colors.amber[300],
                    )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
