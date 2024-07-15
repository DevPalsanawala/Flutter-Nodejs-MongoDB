// To parse this JSON data, do
//
//     final todomodel = todomodelFromJson(jsonString);

import 'dart:convert';

Todomodel todomodelFromJson(String str) => Todomodel.fromJson(json.decode(str));

String todomodelToJson(Todomodel data) => json.encode(data.toJson());

class Todomodel {
  bool status;
  List<Success> success;

  Todomodel({
    required this.status,
    required this.success,
  });

  factory Todomodel.fromJson(Map<String, dynamic> json) => Todomodel(
        status: json["status"],
        success:
            List<Success>.from(json["success"].map((x) => Success.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": List<dynamic>.from(success.map((x) => x.toJson())),
      };
}

class Success {
  String id;
  String userId;
  String title;
  String desc;
  int v;

  Success({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.v,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        desc: json["desc"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "desc": desc,
        "__v": v,
      };
}
