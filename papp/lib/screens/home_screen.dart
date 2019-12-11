import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/points.dart';
import './dashbord_screen.dart';
import './appointment_overview_screen.dart';
import '../screens/create_appointment_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabIndex);
    Provider.of<Points>(context, listen: false).fetchAndSetPoints();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  Widget _buildFab() {
    return _tabController.index == 0
        ? null
        : FloatingActionButton.extended(
            label: Text(
              'Neuer Termin erfassen',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(CreateAppointmentScreen.routeName);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFab(),
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Papp'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'Übersicht',
            ),
            Tab(
              text: 'Termine',
            )
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DashboardScreen(),
          AppointmentOverviewScreen(),
        ],
      ),
    );
  }
}
