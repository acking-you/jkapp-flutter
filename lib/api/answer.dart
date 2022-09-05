import 'package:flutter/foundation.dart';
import 'package:jkapp/api/dio_instance.dart';
import 'package:jkapp/models/answer.dart';
import 'package:jkapp/models/question.dart';

class AnswerApi{
  static final AnswerApi _instance = AnswerApi._internal();

  AnswerApi._internal();
  factory AnswerApi.instance() => _instance;

  Future<AnswerResponse?> getAnswer(String answerId)async{
    try {
      var resp = await HttpUtil.instance().get(
          "jkbd/answer", queryParameters: {"answer_id":answerId});
      if (resp.data != null) {
        var data = resp.data as Map<String, dynamic>;
        try {
          return AnswerResponse.fromJson(data);
        } catch (e) {
          if (kDebugMode) {
            print('change to json error:$e');
          }
          return null;
        }
      }
    }catch(e){
      if (kDebugMode) {
        print('dio get error $e');
      }
    }
    return null;
  }
}
