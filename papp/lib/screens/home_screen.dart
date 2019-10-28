import 'package:flutter/material.dart';

import './dashbord_screen.dart';
import './appointment_overview_screen.dart';

import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Dashboard',
              ),
              Tab(
                text: 'Termine',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DashboardScreen(),
            AppointmentOverviewScreen(),
          ],
        ),
      ),
    );
  }
}
