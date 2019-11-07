import 'package:flutter/material.dart';

class RewardItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String infos;

  RewardItem(this.title, this.imgUrl, this.infos);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                RaisedButton(
                  child: Text(
                    'Auswählen',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {},
                ),
                OutlineButton(
                  child: Text('Details'),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
