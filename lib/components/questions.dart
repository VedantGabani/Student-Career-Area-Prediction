import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _fireStore = Firestore.instance;

class Questions {
  var dataQuestion;
  int questionNumber;
  String question, option1, option2, option3;

  void getFirstQuestion() async {
    dataQuestion = await _fireStore.collection('questions').document('1').get();
    questionNumber = 1;
    question = dataQuestion['question'];
    option1 = dataQuestion['option1'];
    option2 = dataQuestion['option2'];
    option3 = dataQuestion['option3'];
  }
}
