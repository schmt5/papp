import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './providers/appointments.dart';
import './providers/database_provider.dart';
import './models/appointment_model.dart';

import './screens/home_screen.dart';
import './screens/appointment_detail_screen.dart';
import './screens/teddy_screen.dart';
import './screens/user_screen.dart';
import './screens/reward_screen.dart';
import './screens/create_appointment_screen.dart';
import './screens/congratulation_screen.dart';

void main() async {
  await DatabaseProvider.dbProvider.db;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Appointments(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Papp',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal[800],
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: HomeScreen(),
        routes: {
          AppointmentDetailScreen.routeName: (ctx) => AppointmentDetailScreen(),
          TeddyScreen.routeName: (ctx) => TeddyScreen(),
          UserScreen.routeName: (ctx) => UserScreen(),
          RewardScreen.routeName: (ctx) => RewardScreen(),
          CreateAppointmentScreen.routeName: (ctx) => CreateAppointmentScreen(),
          CongratulationScreen.routeName: (ctx) => CongratulationScreen(),
        },
      ),
    );
  }
}
