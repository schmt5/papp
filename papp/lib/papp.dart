import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './providers/appointments.dart';
import './providers/database_provider.dart';
import './providers/points.dart';
import './providers/onboarding.dart';
import './models/appointment_model.dart';

import './screens/home_screen.dart';
import './screens/appointment_detail_screen.dart';
import './screens/teddy_screen.dart';
import './screens/user_screen.dart';
import './screens/reward_screen.dart';
import './screens/create_appointment_screen.dart';
import './screens/congratulation_screen.dart';
import './screens/onboarding_screen.dart';

class Papp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Onboarding>(context).fetchAndSetOnboarding(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<Onboarding>(
            builder: (context, onboardingData, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
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
              home: onboardingData.isOnboarded
                  ? HomeScreen()
                  : OnboardingScreen(),
              routes: {
                HomeScreen.routeName: (ctx) => HomeScreen(),
                AppointmentDetailScreen.routeName: (ctx) =>
                    AppointmentDetailScreen(),
                TeddyScreen.routeName: (ctx) => TeddyScreen(),
                UserScreen.routeName: (ctx) => UserScreen(),
                RewardScreen.routeName: (ctx) => RewardScreen(),
                CreateAppointmentScreen.routeName: (ctx) =>
                    CreateAppointmentScreen(),
                CongratulationScreen.routeName: (ctx) => CongratulationScreen(),
                OnboardingScreen.routeName: (ctx) => OnboardingScreen(),
              },
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
