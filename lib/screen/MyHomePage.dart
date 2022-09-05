import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jkapp/components/my_button.dart';
import 'package:jkapp/screen/QuestionPage.dart';
import 'package:jkapp/service/QuestionService.dart';

class MyHomePage extends StatefulWidget {
  static const id = "init_page";
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           MyButton(()async{
             var response = await QuestionService.getResponse(0);
             if(response == null){
                EasyLoading.showError("获取题目失败");
                return;
             }
             Navigator.of(context).push(MaterialPageRoute(builder: (c){
               return QuestionPage(response,"模拟考试",Colors.blue);
             }));
           }, Colors.lightBlueAccent, Colors.lightBlue, "模拟考试"),
            MyButton(()async{
              var response = await QuestionService.getResponse(1);
              if(response == null){
                EasyLoading.showError("获取题目失败");
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(builder: (c){
                return QuestionPage(response,"专项练习",Colors.blueAccent);
              }));
            }, Colors.blueAccent, Colors.blue, "专项练习")
          ],
        ),
      ),
    );
  }
}
