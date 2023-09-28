// To parse this JSON data, do
//
//     final buses = busesFromJson(jsonString);

import 'dart:convert';

Buses busesFromJson(String str) => Buses.fromJson(json.decode(str));

String busesToJson(Buses data) => json.encode(data.toJson());

class Buses {
  bool? status;
  List<Bus>? bus;

  Buses({
    this.status,
    this.bus,
  });

  factory Buses.fromJson(Map<String, dynamic> json) => Buses(
    status: json["status"],
    bus: json["data"] == null ? [] : List<Bus>.from(json["data"]!.map((x) => Bus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": bus == null ? [] : List<dynamic>.from(bus!.map((x) => x.toJson())),
  };
}

class Bus {
  String? id;
  String? source;
  String? destination;
  DateTime? startTime;
  int? capacity;
  int? initialCapacity;
  List<String>? stops;
  List<String>? days;
  bool? sessionStart;
  int? v;

  Bus({
    this.id,
    this.source,
    this.destination,
    this.startTime,
    this.capacity,
    this.initialCapacity,
    this.stops,
    this.days,
    this.sessionStart,
    this.v,
  });

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
    id: json["_id"],
    source: json["source"],
    destination: json["destination"],
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    capacity: json["capacity"],
    initialCapacity: json["initialCapacity"],
    stops: json["stops"] == null ? [] : List<String>.from(json["stops"]!.map((x) => x)),
    days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
    sessionStart: json["sessionStart"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "source": source,
    "destination": destination,
    "startTime": startTime?.toIso8601String(),
    "capacity": capacity,
    "initialCapacity": initialCapacity,
    "stops": stops == null ? [] : List<dynamic>.from(stops!.map((x) => x)),
    "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
    "sessionStart": sessionStart,
    "__v": v,
  };
}
