import 'package:career_mentor/components/alert_dialogs.dart';
import 'package:career_mentor/components/auth_service.dart';
import 'package:career_mentor/components/bubble_button.dart';
import 'package:career_mentor/components/decorate_circle.dart';
import 'package:career_mentor/components/option_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'dashboard.dart';
import 'result.dart';

final _fireStore = Firestore.instance;
final _fireBase = FirebaseDatabase.instance;

class Test extends StatefulWidget {
  static String id = 'test';
  static List<double> answer = new List<double>();
  static var dateTime;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<RadioModel> optionsList = new List<RadioModel>();
  var dataQuestion;
  int questionNumber, id, counter = 1;
  String question, option1, option2, option3;
  Map<int, List<int>> nextQuestion = Map();
  Map<int, List<double>> weight = Map();
  bool isLoading = false;
  List<double> wei = [0, 0, 0, 0];
  Map<String, String> ansMap = Map();

  void getFirstQuestion() async {
    setState(() {
      isLoading = true;
    });
    dataQuestion = await _fireStore.collection('questions').document('1').get();
    Test.dateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    setState(() {
      questionNumber = 1;
      question = dataQuestion['question'];
      option1 = dataQuestion['option1'];
      option2 = dataQuestion['option2'];
      option3 = dataQuestion['option3'];
      optionsList.add(new RadioModel(false, '$option1'));
      optionsList.add(new RadioModel(false, '$option2'));
      optionsList.add(new RadioModel(false, '$option3'));
      isLoading = false;
    });
  }

  Future getQuestion() async {
    nextQuestion = {
      1: [13, 3, 14],
      2: [10, 8, 8],
      3: [5, 2, 4],
      4: [11, 5, 5],
      5: [28, 11, 11],
      6: [18, 9, 9],
      7: [17, 6, 17],
      8: [27, 10, 10],
      9: [24, 18, 18],
      10: [27, 4, 27],
      11: [16, 28, 28],
      12: [22, 16, 16],
      13: [15, 15, 2],
      14: [15, 15, 3],
      15: [25, 20, 2],
      16: [23, 22, 22],
      17: [9, 21, 21],
      18: [46, 19, 19],
      19: [46, 46, 47],
      20: [34, 25, 2],
      21: [24, 24, 9],
      22: [23, 33, 30],
      23: [31, 33, 33],
      24: [44, 26, 26],
      25: [35, 34, 2],
      26: [44, 44, 19],
      27: [29, 12, 12],
      28: [29, 30, 29],
      29: [30, 30, 32],
      30: [7, 32, 32],
      31: [42, 41, 42],
      32: [17, 6, 7],
      33: [31, 30, 30],
      34: [36, 35, 35],
      35: [38, 36, 36],
      36: [37, 38, 37],
      37: [38, 39, 39],
      38: [40, 39, 39],
      39: [45, 40, 40],
      40: [45, 72, 72],
      41: [43, 7, 43],
      42: [41, 7, 41],
      43: [64, 67, 67],
      44: [63, 62, 62],
      45: [72, 74, 74],
      46: [47, 48, 48],
      47: [49, 49, 48],
      48: [34, 50, 51],
      49: [51, 34, 51],
      50: [53, 51, 51],
      51: [35, 35, 52],
      52: [54, 53, 54],
      53: [54, 54, 55],
      54: [38, 55, 38],
      55: [56, 57, 56],
      56: [58, 38, 58],
      57: [58, 58, 61],
      58: [59, 61, 59],
      59: [61, 61, 61],
      61: [82, 82, 82],
      62: [63, 38, 66],
      63: [68, 66, 66],
      64: [69, 69, 6],
      66: [68, 71, 71],
      67: [64, 64, 9],
      68: [81, 81, 81],
      69: [70, 73, 73],
      70: [83, 83, 83],
      71: [68, 68, 68],
      72: [75, 74, 74],
      73: [80, 21, 80],
      74: [75, 76, 66],
      75: [77, 76, 77],
      76: [79, 77, 77],
      77: [78, 66, 78],
      78: [84, 79, 79],
      79: [84, 84, 84],
      80: [21, 70, 70],
    };

    weight = {
      1: [1, 0, 0.5, 0],
      2: [1, 0, 0.5, 3],
      3: [1, 0, 0.5, 1],
      4: [1, 0, 0.5, 1],
      5: [1, 0, 0.5, 1],
      6: [1, 0, 0.5, 2],
      7: [1, 0, 0.5, 1],
      8: [1, 0, 0.5, 3],
      9: [1, 0, 0.5, 1],
      10: [1, 0, 0.5, 3],
      11: [1, 0, 0.5, 3],
      12: [1, 0, 0.5, 3],
      13: [1, 0.5, 0, 0],
      14: [1, 0.5, 0, 0],
      15: [1, 0.5, 0, 0],
      16: [1, 0.5, 0, 3],
      17: [1, 0.5, 0, 2],
      18: [1, 0.5, 0, 2],
      19: [1, 0.5, 0, 2],
      20: [1, 0.5, 0, 0],
      21: [1, 0.5, 0, 1],
      22: [1, 0.5, 0, 3],
      23: [1, 0.5, 0, 3],
      24: [1, 0.5, 0, 1],
      25: [1, 0.5, 0, 0],
      26: [1, 0.5, 0, 1],
      27: [1, 0, 0, 1],
      28: [0, 1, 0, 1],
      29: [0, 0, 1, 1],
      30: [1, 0, 0, 1],
      31: [0, 1, 0, 3],
      32: [0, 0, 1, 1],
      33: [1, 0, 0, 3],
      34: [1, 0, 0.5, 0],
      35: [1, 0.5, 0, 0],
      36: [0, 1, 0.5, 0],
      37: [1, 0, 0.5, 0],
      38: [1, 0, 0.5, 0],
      39: [1, 0, 0.5, 0],
      40: [1, 0, 0.5, 0],
      41: [1, 0, 0.5, 3],
      42: [1, 0, 0.5, 3],
      43: [1, 0, 0.5, 3],
      44: [1, 0, 0.5, 1],
      45: [1, 0, 0.5, 0],
      46: [0, 1, 0, 2],
      47: [0, 0, 1, 2],
      48: [0, 1, 0, 2],
      49: [1, 0, 0, 2],
      50: [1, 0, 0, 2],
      51: [0, 0, 1, 2],
      52: [0, 1, 0, 2],
      53: [0, 0, 1, 2],
      54: [0, 1, 0, 2],
      55: [0, 1, 0, 2],
      56: [1, 0, 0, 2],
      57: [0, 0, 1, 2],
      58: [0, 1, 0, 2],
      59: [0, 1, 0, 2],
      61: [0, 1, 0, 2],
      62: [1, 0, 0.5, 1],
      63: [1, 0.5, 0, 1],
      64: [1, 0.5, 0, 3],
      66: [1, 0.5, 0, 1],
      67: [1, 0.5, 0, 3],
      68: [1, 0.5, 0, 1],
      69: [1, 0.5, 0, 3],
      70: [1, 0.5, 0, 3],
      71: [1, 0, 0.5, 1],
      72: [1, 0, 0.5, 0],
      73: [1, 0, 0.5, 3],
      74: [1, 0.5, 0, 0],
      75: [1, 0, 0.5, 0],
      76: [1, 0, 0.5, 0],
      77: [1, 0, 1, 1],
      78: [1, 0, 0.5, 0],
      79: [0, 0.5, 1, 0],
      80: [0, 0.5, 1, 3],
    };

    wei[weight[questionNumber][3].toInt()] += weight[questionNumber][id];

    //print('if $id');
    if (id == 0) {
      questionNumber = nextQuestion[questionNumber][0];
    } else if (id == 1) {
      questionNumber = nextQuestion[questionNumber][1];
    } else if (id == 2) {
      questionNumber = nextQuestion[questionNumber][2];
    }
    dataQuestion = await _fireStore
        .collection('questions')
        .document('$questionNumber')
        .get();
    if (questionNumber < 81) {
      setState(() {
        //print(wei);
        //print('1$id');
        counter++;
        question = dataQuestion['question'];
        option1 = dataQuestion['option1'];
        option2 = dataQuestion['option2'];
        option3 = dataQuestion['option3'];
        optionsList.removeRange(0, optionsList.length);
        optionsList.add(new RadioModel(false, '$option1'));
        optionsList.add(new RadioModel(false, '$option2'));
        optionsList.add(new RadioModel(false, '$option3'));
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          backgroundColor: Color(0xFFFDFDFD),
          content: Container(
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              color: Color(0xFFFDFDFD),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'images/cdone_1.gif',
                  height: 250,
                  width: 250,
                ),
                Text(
                  'Well done!',
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF252C49),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
//      _fireStore
//          .collection('data')
//          .document('${authService.profile['email']}')
//          .collection('${Test.dateTime}')
//          .document('${Test.dateTime}')
//          .setData({'ansmap': ansMap}, merge: true);
      _fireBase
          .reference()
          .child('${authService.profile['uid']}')
          .child('${Test.dateTime}')
          .set({
        'ansmap': ansMap,
        'weigth': null,
        'result': null,
        'satisfaction': null,
        'ssc': null
      });
      Future.delayed(Duration(milliseconds: 2500), () {
        Test.answer = wei;
        questionNumber = 1;
        Navigator.popAndPushNamed(context, Result.id);
      });
    }
  }

  @override
  void initState() {
    getFirstQuestion();
    super.initState();
  }

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
            title: Text('Career Mentor'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Logout',
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.popAndPushNamed(context, DashBoard.id);
                  authService.signOut();
                },
              ),
            ],
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: Text(
                                'Question $counter',
                                style: TextStyle(
                                  fontSize: w * 0.0694,
                                  color: Color(0xFF8D93B7),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            dashWidget(w * 0.84),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              constraints: BoxConstraints(minHeight: 100.0),
                              child: Text(
                                '$question',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
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
//                            SizedBox(
//                              height: h * 0.0481,
//                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: h * 0.18,
                      left: w * 0.075,
                      height: h * 0.307,
                      width: w * 0.85,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(0.0),
                              color: Color(0xFF091B3A),
                              elevation: 0.0,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(
                                  () {
                                    if (optionsList[index].isSelected != true) {
                                      optionsList.forEach((element) =>
                                          element.isSelected = false);
                                      optionsList[index].isSelected = true;
                                      id = index;
                                      //print('op$id');
                                    }
                                  },
                                );
                              },
                              child: OptionButton(item: optionsList[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: w * 0.1,
                      bottom: h * 0.07,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.2),
                        child: BubbleButton(
                          buttonWidth: w * 0.4,
                          title: 'Next',
                          textPadding: 20.0,
                          buttonFunction: () async {
                            if (id != null) {
                              setState(() {
                                print(isLoading);
                                isLoading = true;
                              });
                              ansMap['$questionNumber'] = '$id';
                              await getQuestion();
                              //print('bn$id');
                              id = null;
                              setState(() {
                                print(isLoading);
                                isLoading = false;
                              });
                              //print('an$id');
                            } else {
                              Fluttertoast.showToast(
                                msg: 'please select answer',
                              );
                            }
                          },
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

const double dashWidth = 2, emptyWidth = 3, dashHeight = 1;
const Color dashColor = Color(0xFF8D93B7);
Widget dashWidget(wid) {
  return Row(
    children: List.generate(
      wid ~/ (dashWidth + emptyWidth),
      (_) => Container(
        width: dashWidth,
        height: dashHeight,
        color: dashColor,
        margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
      ),
    ),
  );
}
