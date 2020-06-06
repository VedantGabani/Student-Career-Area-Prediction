import 'package:career_mentor/components/alert_dialogs.dart';
import 'package:career_mentor/components/auth_service.dart';
import 'package:career_mentor/components/bubble_button.dart';
import 'package:career_mentor/components/decorate_circle.dart';
import 'package:career_mentor/components/option_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dashboard.dart';
import 'login.dart';
import 'test.dart';

final _fireBase = FirebaseDatabase.instance;

class Satisfaction extends StatefulWidget {
  static String id = 'satisfaction';

  @override
  _SatisfactionState createState() => _SatisfactionState();
}

class _SatisfactionState extends State<Satisfaction> {
  List<RadioModel> optionSSC = [
    new RadioModel(false, 'Yes'),
    new RadioModel(false, 'No')
  ];
  bool userAnswer;

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
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: 100.0),
                        child: Text(
                          'Are you satisfied with our prediction?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2.0,
                            letterSpacing: 0.8,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: h * 0.07,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionSSC.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(0.0),
                              color: Color(0xFF091B3A),
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(
                                  () {
                                    if (optionSSC[index].isSelected != true) {
                                      optionSSC.forEach((element) =>
                                          element.isSelected = false);
                                      optionSSC[index].isSelected = true;
                                      userAnswer = index == 0 ? true : false;
                                    }
                                  },
                                );
                              },
                              child: OptionButton(item: optionSSC[index]),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: h * 0.23,
                left: w * 0.25,
                child: BubbleButton(
                  buttonWidth: w * 0.5,
                  title: 'Submit',
                  textPadding: 20.0,
                  buttonFunction: () {
                    if (userAnswer != null) {
//                      _fireStore
//                          .collection('data')
//                          .document('${authService.profile['email']}')
//                          .collection('${Test.dateTime}')
//                          .document('${Test.dateTime}')
//                          .setData({'satisfaction': userAnswer}, merge: true);
                      _fireBase
                          .reference()
                          .child('${authService.profile['uid']}')
                          .child('${Test.dateTime}')
                          .update({'satisfaction': userAnswer});
                      Navigator.popAndPushNamed(context, DashBoard.id);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'please select answer',
                      );
                    }
                  },
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
