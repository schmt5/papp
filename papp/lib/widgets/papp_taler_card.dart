import 'package:flutter/material.dart';

class PappTalerCard extends StatelessWidget {
  final int pappTaler = 5;
  final double percentOfReward = 0.1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('$pappTaler Papp Taler'),
            ),
            ListTile(
              title: LayoutBuilder(
                builder: (ctx, constraints) {
                  return Row(
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: constraints.maxWidth * percentOfReward,
                        color: Colors.amber[300],
                      ),
                      Container(
                        height: 20,
                        width: constraints.maxWidth * (1 - percentOfReward),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.amber[300]
                          )
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}