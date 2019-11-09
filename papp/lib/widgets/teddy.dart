import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_dart/actor.dart';

class Teddy extends StatefulWidget {
  @override
  _TeddyState createState() => _TeddyState();
}

class _TeddyState extends State<Teddy> {
  final _flareFile = 'assets/teddy.flr';
  var _currentAnimation = 'idle';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentAnimation = 'fail';
        });
      },
      child: Container(
        height: 400,
        child: FlareActor(
          _flareFile,
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          animation: _currentAnimation,
          callback: (_) {
            setState(() {
              _currentAnimation = 'idle';
            });
          },
        ),
      ),
    );
  }
}
