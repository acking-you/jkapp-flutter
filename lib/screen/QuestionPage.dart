import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:jkapp/api/answer.dart';
import 'package:jkapp/constants.dart';
import 'package:jkapp/models/answer.dart';
import 'package:jkapp/models/question.dart';
import 'package:jkapp/service/QuestionService.dart';

class QuestionPage extends StatefulWidget {
  static const id = "question_page";
  QuestionResponse questionResponse;
  String titleText;
  Color titleColor;

  QuestionPage(this.questionResponse, this.titleText, this.titleColor,
      {Key? key})
      : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late QuestionResponse questionResponse;
  late String titleText;
  late Color titleColor;
  int _index = 0;
  bool showAnswer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionResponse = widget.questionResponse;
    titleColor = widget.titleColor;
    titleText = widget.titleText;
  }

  Data getData() {
    if (questionResponse.data == null || questionResponse.data!.isEmpty) {
      EasyLoading.showError("数据为空！返回默认数据！");
      return QuestionService.getDefaultData();
    }
    return questionResponse.data![_index % questionResponse.data!.length];
  }

  void next() {
    _index++;
  }

  void prev() {
    _index--;
    if (_index < 0) _index = 0;
  }

  void onOptionPressed() {
    setState(() {
      showAnswer = true;
    });
  }

  void onNextButtonPressed() {
    setState(() {
      next();
      showAnswer = false;
    });
  }

  void onPrevButtonPressed() {
    setState(() {
      prev();
      showAnswer = false;
    });
  }

  Widget getNextAndPrevButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onPrevButtonPressed,
          child: Text(
            "上一题",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
          ),
        ),
        TextButton(
            onPressed: onNextButtonPressed,
            child: Text(
              "下一题",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            )),
      ],
    );
  }

  Widget getTitleWidget() {
    return TextButton(
      onPressed: null,
      child: Text(
        titleText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(titleColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
          elevation: MaterialStateProperty.all(10.0),
          fixedSize: MaterialStateProperty.all(Size(400, 70))),
    );
  }

  Widget getAnswerWidget() {
    return !showAnswer
        ? SizedBox(
            height: 5,
          )
        : FutureBuilder(
            future: AnswerApi.instance().getAnswer(getData().id!),
            builder: (context, snipate) {
              AnswerResponse? answerResponse;
              if (snipate.hasData)
                answerResponse = snipate.data as AnswerResponse?;
              return answerResponse == null
                  ? SizedBox(
                      height: 5.0,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "题目答案",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          answerResponse.data!.answer!,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "题目解析",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        HtmlWidget(
                          answerResponse.data!.description!,
                        ),
                      ],
                    );
            });
  }

  Widget getContentWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        getData().content!,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }

  String _solveString(String raw) {
    var newStr = raw.replaceAll("'", "");
    return newStr;
  }

  Widget getIconWidget() {
    return getData().image == null || getData().image!.isEmpty
        ? SizedBox(
            height: 5.0,
          )
        : Image.network('http:${_solveString(getData().image!)}');
  }

  Widget getOptionsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (String text in getData().options!)
          TextButton(
              onPressed: onOptionPressed,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.lightBlue,
                ),
              ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questionResponse.data == null) {
      EasyLoading.showError("无数据，数据为空");
      return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: kOuterBoxDecoration,
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: kOuterBoxDecoration,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        Center(
          child: Container(
            width: 480,
            height: 600,
            decoration: kInternalBoxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  getTitleWidget(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: ListView(children: [
                      getContentWidget(),
                      getIconWidget(),
                      const SizedBox(
                        height: 50.0,
                      ),
                      getOptionsWidget(),
                      const SizedBox(
                        height: 50.0,
                      ),
                      getAnswerWidget(),
                    ]),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  getNextAndPrevButton(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
