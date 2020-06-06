import 'package:career_mentor/components/alert_dialogs.dart';
import 'package:career_mentor/components/auth_service.dart';
import 'package:career_mentor/components/bubble_button.dart';
import 'package:career_mentor/components/decorate_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'test.dart';

class DashBoard extends StatefulWidget {
  static String id = 'dashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await AlertDialogs(
              context: context,
              yesFunction: () {
                authService.signOut();
                Navigator.popAndPushNamed(context, LogIn.id);
              },
              noFunction: () {
                Navigator.of(context).pop(false);
              },
              heading: 'Are you sure?',
              warning: 'Do you want to sign out and go back?',
            ).onWillPop() ??
            false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: null,
            title: Text('Career Mentor'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Logout',
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  authService.signOut();
                  Navigator.popAndPushNamed(context, LogIn.id);
                },
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: h * 0.1,
                      ),
                      Container(
                        height: 95.0,
                        width: 95.0,
                        child: ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'images/profile.jpg',
                            image: '${authService.profile['photoURL']}',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        child: Text(
                          "WELCOME\n${authService.profile['displayName']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2.0,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.1,
                      ),
                      BubbleButton(
                        buttonWidth: w * 0.4,
                        title: 'Test',
                        textPadding: 20.0,
                        buttonFunction: () {
                          Navigator.pushNamed(context, Test.id);
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
