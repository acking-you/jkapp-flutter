


import 'package:flutter_test/flutter_test.dart';
import 'package:jkapp/api/answer.dart';
import 'package:jkapp/api/exam.dart';
import 'package:jkapp/api/practice.dart';
import 'package:jkapp/models/answer.dart';
import 'package:jkapp/models/question.dart';

void main(){
  test("examapi",

      () async {
        ExamApi.instance().getExamQuestion().then((value) => print('$value'));

      }

  );

  test("practiceApi", ()async{
   var resp = await PracticeApi.instance().getPracticeQuestion();
   print(resp?.toJson());

  });
  
  test("answerApi", ( )async{
    var resp = await AnswerApi.instance().getAnswer("e9c3b");
    print(resp?.toJson());
  });
}