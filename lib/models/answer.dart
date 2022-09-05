class AnswerResponse {
  int? statusCode;
  String? statusMessage;
  AnswerData? data;

  AnswerResponse({this.statusCode, this.statusMessage, this.data});

  AnswerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? AnswerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AnswerData {
  String? answer;
  String? description;

  AnswerData({this.answer, this.description});

  AnswerData.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer'] = answer;
    data['description'] = description;
    return data;
  }
}
