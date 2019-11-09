import 'package:flutter/material.dart';

import '../widgets/teddy.dart';

class TeddyScreen extends StatelessWidget {
  static const routeName = '/teddy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teddy'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Teddy(),
         
        ],
      )
    );
  }
}
