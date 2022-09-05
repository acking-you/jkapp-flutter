import 'package:flutter/foundation.dart';
import 'package:jkapp/api/dio_instance.dart';
import 'package:jkapp/models/question.dart';

class PracticeApi{
  static final PracticeApi _instance = PracticeApi._internal();

  PracticeApi._internal();
  factory PracticeApi.instance() => _instance;

  Future<QuestionResponse?> getPracticeQuestion()async{
    try {
      var resp = await HttpUtil.instance().get(
          "jkbd/zxcs/questions", queryParameters: {"zid": 203, "category": 0});
      if (resp.data != null) {
        var data = resp.data as Map<String, dynamic>;
        try {
          return QuestionResponse.fromJson(data);
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
