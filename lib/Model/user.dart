// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  bool? status;
  List<User>? users;

  UserData({
    this.status,
    this.users,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    users: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  String? id;
  String? source;
  String? destination;
  DateTime? startTime;
  String? email;
  String? txnId;
  String? busId;
  bool? verified;
  int? v;

  User({
    this.id,
    this.source,
    this.destination,
    this.startTime,
    this.email,
    this.txnId,
    this.busId,
    this.verified,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    source: json["source"],
    destination: json["destination"],
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    email: json["email"],
    txnId: json["txnId"],
    busId: json["busId"],
    verified: json["verified"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "source": source,
    "destination": destination,
    "startTime": startTime?.toIso8601String(),
    "email": email,
    "txnId": txnId,
    "busId": busId,
    "verified": verified,
    "__v": v,
  };
}
