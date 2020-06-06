import 'dart:math';

import 'package:career_mentor/components/alert_dialogs.dart';
import 'package:career_mentor/components/auth_service.dart';
import 'package:career_mentor/components/bubble_button.dart';
import 'package:career_mentor/components/decorate_circle.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login.dart';
import 'review.dart';
import 'test.dart';

final _fireBase = FirebaseDatabase.instance;

class Result extends StatefulWidget {
  static String id = 'result';

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  static String getAnswer(List<double> answer) {
//    _fireStore
//        .collection('data')
//        .document('${authService.profile['email']}')
//        .collection('${Test.dateTime}')
//        .document('${Test.dateTime}')
//        .setData({'weigth': answer}, merge: true);
    _fireBase
        .reference()
        .child('${authService.profile['uid']}')
        .child('${Test.dateTime}')
        .update({'weigth': answer});
    double m = answer.reduce(max);
    int index = answer.indexOf(m);
    List<String> results = [
      'Arts & Humanities',
      'Science with maths',
      'Science with biology',
      'Commerce'
    ];
    return results[index];
  }

  String answer = getAnswer(Test.answer);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await AlertDialogs(
              context: context,
              yesFunction: () {
                Navigator.popAndPushNamed(context, DashBoard.id);
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
          appBar: AppBar(
            centerTitle: true,
            leading: null,
            title: Text('Career Mentor'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Logout',
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.popAndPushNamed(context, LogIn.id);
                  authService.signOut();
                },
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border:
                              Border.all(width: 3.0, color: Color(0xFF22486F)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              width: 70.0,
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'images/profile.jpg',
                                    image:
                                        '${authService.profile['photoURL']}'),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              child: Text(
                                authService.profile['displayName'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.06,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border:
                              Border.all(width: 3.0, color: Color(0xFF22486F)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Your Interest\n',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              answer,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xDDEA4C89),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '\nTest completed successfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF51a1f0),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Center(
                        child: BubbleButton(
                          buttonWidth: w * 0.5,
                          title: 'Feedback',
                          textPadding: 20.0,
                          buttonFunction: () {
//                            _fireStore
//                                .collection('data')
//                                .document('${authService.profile['email']}')
//                                .collection('${Test.dateTime}')
//                                .document('${Test.dateTime}')
//                                .setData({'result': answer}, merge: true);
                            _fireBase
                                .reference()
                                .child('${authService.profile['uid']}')
                                .child('${Test.dateTime}')
                                .update({'result': answer});
                            Navigator.popAndPushNamed(context, Review.id);
                          },
                        ),
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
