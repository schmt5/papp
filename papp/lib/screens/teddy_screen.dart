import 'package:flutter/material.dart';

class TeddyScreen extends StatelessWidget {
  static const routeName = '/teddy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teddy'),
      ),
      body: Center(
        child: Text('Teddy Screen'),
      ),
    );
  }
}
