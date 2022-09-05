class QuestionResponse {
  int? statusCode;
  String? statusMessage;
  List<Data>? data;

  QuestionResponse({this.statusCode, this.statusMessage, this.data});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? content;
  int? category;
  List<String>? options;
  String? image;

  Data({this.id, this.content, this.category, this.options, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    category = json['category'];
    options = json['options'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['category'] = category;
    data['options'] = options;
    data['image'] = image;
    return data;
  }
}
