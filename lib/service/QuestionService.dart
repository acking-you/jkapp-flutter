

import 'package:jkapp/api/exam.dart';
import 'package:jkapp/api/practice.dart';
import 'package:jkapp/models/question.dart';

class QuestionService{

  static Future<QuestionResponse?> getResponse(int category){
    switch(category){
      case 0:
        return ExamApi.instance().getExamQuestion();
      case 1:
        return PracticeApi.instance().getPracticeQuestion();
    }
    return Future.error("null error");
  }
  static Data getDefaultData(){
    return Data(id: "b85c7",content: "在道路上跟车行驶时，跟车距离不是主要的，只须保持与前车相等的速度，即可防止发生追尾事故",category: 1,
    options: [
      "A、正确",
      "B、错误"
    ]);
  }
}