import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/dashboard.dart';
import 'screens/login.dart';
import 'screens/registration.dart';
import 'screens/result.dart';
import 'screens/review.dart';
import 'screens/review_2.dart';
import 'screens/test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Mentor',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF091B3A),
        appBarTheme: AppBarTheme(
          color: Color(0xFF011029),
        ),
      ),
      initialRoute: LogIn.id,
      routes: {
        LogIn.id: (context) => LogIn(),
        Registration.id: (context) => Registration(),
        DashBoard.id: (context) => DashBoard(),
        Test.id: (context) => Test(),
        Result.id: (context) => Result(),
        Review.id: (context) => Review(),
        Satisfaction.id: (context) => Satisfaction(),
      },
    );
  }
}
