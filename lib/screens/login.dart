import 'package:career_mentor/components/alert_dialogs.dart';
import 'package:career_mentor/components/auth_service.dart';
import 'package:career_mentor/components/bubble_button.dart';
import 'package:career_mentor/components/decorate_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard.dart';

class LogIn extends StatefulWidget {
  static String id = 'login';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await AlertDialogs(
              context: context,
              yesFunction: () {
                SystemNavigator.pop();
              },
              noFunction: () {
                Navigator.of(context).pop(false);
              },
              heading: 'Are you sure?',
              warning: 'Do you want to exit an App',
            ).onWillPop() ??
            false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: h * 0.1,
                            ),
                            Container(
                              height: 180.0,
                              child: Image.asset('images/logo.png'),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Container(
                              child: Text(
                                "CAREER MENTOR",
                                style: TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: "Horizon",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            BubbleButton(
                              buttonWidth: w * 0.6,
                              title: 'Sign In',
                              buttonImage:
                                  Image.asset('images/google_logo.png'),
                              textPadding: 20.0,
                              buttonFunction: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool check = await authService.googleSignIn();
                                if (check) {
                                  Navigator.pushNamed(context, DashBoard.id);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              DecorateCircle(
                  bottoms: h * 0.102489,
                  lefts: w * 0.0731,
                  width: 10.0,
                  colour: 0xFF0B9DAF),
              DecorateCircle(
                  bottoms: h * 0.0366,
                  lefts: w * 0.083,
                  width: 24.0,
                  colour: 0xDDEA4C89),
              DecorateCircle(
                  bottoms: -h * 0.0586,
                  lefts: w * 0.1463,
                  width: 60.0,
                  colour: 0xFF0B925E),
              DecorateCircle(
                  bottoms: h * 0.0,
                  lefts: w * 0.4146,
                  width: 10.0,
                  colour: 0xFF0B5FB6),
              DecorateCircle(
                  bottoms: h * 0.0293,
                  lefts: w * 0.5366,
                  width: 10.0,
                  colour: 0xFF79AD1C),
              DecorateCircle(
                  bottoms: h * 0.0102,
                  lefts: w * 0.6096,
                  width: 30.0,
                  colour: 0xFF0B9497),
              DecorateCircle(
                  bottoms: h * 0.0878,
                  rights: w * 0.0976,
                  width: 10.0,
                  colour: 0xFF63698B),
              DecorateCircle(
                  bottoms: -h * 0.0400,
                  rights: w * 0.0976,
                  width: 40.0,
                  colour: 0xFF3278A0),
              DecorateCircle(
                  bottoms: h * 0.02928,
                  rights: -w * 0.0317,
                  width: 20.0,
                  colour: 0xFF0D8A61),
            ],
          ),
        ),
      ),
    );
  }
}
