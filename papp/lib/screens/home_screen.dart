import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../providers/points.dart';
import './dashbord_screen.dart';
import './appointment_overview_screen.dart';
import '../screens/create_appointment_screen.dart';
import '../widgets/app_drawer.dart';
import './create_therapy_screen.dart';

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
    return Visibility(
      visible: _tabController.index == 1,
      child: SpeedDial(
        marginRight: 30,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.add_event,
        animatedIconTheme: IconThemeData(size: 36),
        children: [
          SpeedDialChild(
            
            backgroundColor: Colors.blue,
            child: Icon(Icons.category),
            label: 'Therapie',
            onTap: () {
              Navigator.of(context).pushNamed(CreateTherapyScreen.routeName);
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.green,
            child: Icon(Icons.accessibility_new),
            label: 'Übung',
            onTap: () {},
          ),
          SpeedDialChild(
            
            backgroundColor: Colors.orange,
            child: Icon(
              Icons.adjust,
             
            ),
            label: 'Privater Termin',
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _buildFabOld() {
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
