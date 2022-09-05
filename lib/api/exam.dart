

import 'package:flutter/foundation.dart';
import 'package:jkapp/api/dio_instance.dart';
import 'package:jkapp/models/question.dart';

class ExamApi{
  static final ExamApi _instance = ExamApi._internal();

  ExamApi._internal();
  factory ExamApi.instance() => _instance;

  Future<QuestionResponse?> getExamQuestion()async{
    try {
      var resp = await HttpUtil.instance().get(
          "jkbd/exam", queryParameters: {"city": "changsha", "category": 0});
      if (resp.data != null) {
        var data = resp.data as Map<String, dynamic>;
        try {
          if (kDebugMode) {
            print(data);
          }
          return QuestionResponse.fromJson(data);
        } catch (e) {
          if (kDebugMode) {
            print('change to json error:$e');
          }
          return null;
        }
      }
    }catch(e){
      print('-----------------------------dio get error $e');
    }
    return null;
  }
}
