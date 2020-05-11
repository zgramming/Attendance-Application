import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import './ui/screens/splash_screen.dart';

import './ui/screens/welcome_screen.dart';
import './ui/screens/login_screen.dart';
import './ui/screens/maps_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorPallete.primaryColor,
        accentColor: colorPallete.accentColor,
        scaffoldBackgroundColor: colorPallete.scaffoldColor,
        cardTheme: const CardTheme(elevation: 3),
        fontFamily: 'VarelaRound',
      ),
      home: SplashScreen(),
      routes: {
        WelcomeScreen.routeNamed: (context) => WelcomeScreen(),
        LoginScreen.routeNamed: (context) => LoginScreen(),
        MapScreen.routeNamed: (context) => MapScreen(),
      },
    );
  }
}
