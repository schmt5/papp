import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import '../models/reward_type.dart';

class RewardItem extends StatelessWidget {
  final String title;
  final RewardType type;
  final String imgUrl;
  final String infos;

  RewardItem(this.title, this.type, this.imgUrl, this.infos);

  void _showDetailModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.black87,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 18,
                ),
                child: Text(
                  infos,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RaisedButton(
                  child: Text(
                    'Zurück',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  color: Theme.of(ctx).accentColor,
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Points>(context).fetchAndSetPoints(),
      builder: (context, snapshot) {
        return Consumer<Points>(
          builder: (context, pointData, _) {
            return Card(
              color: type.index == pointData.choosenReward
                  ? Colors.amberAccent
                  : null,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          imgUrl,
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
                            title,
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ButtonBar(
                      children: <Widget>[
                        type.index == pointData.choosenReward
                            ? Text(
                                'Von dir ausgewählt',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : RaisedButton(
                                child: Text(
                                  'Auswählen',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  pointData.setChoosenReward(type.index);
                                },
                              ),
                        OutlineButton(
                          borderSide: BorderSide(width: 1.5),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => _showDetailModalSheet(context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
