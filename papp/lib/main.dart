import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './papp.dart';

import './providers/appointments.dart';
import './providers/database_provider.dart';
import './providers/points.dart';
import './providers/onboarding.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          value: Onboarding(),
        ),
        ChangeNotifierProvider.value(
          value: Appointments(),
        ),
        ChangeNotifierProvider.value(
          value: Points(),
        ),
      ],
      child: Papp(),
    );
  }
}
