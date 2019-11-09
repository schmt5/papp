import 'package:flutter/material.dart';

import '../screens/reward_screen.dart';
import '../screens/teddy_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Mein Profil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Teddy'),
            onTap: () {
              Navigator.of(context).pushNamed(TeddyScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('Belohnung'),
            onTap: () {
              Navigator.of(context).pushNamed(RewardScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.trending_up),
            title: Text('Dein Fortschritt'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Datenschutzerklärung'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
