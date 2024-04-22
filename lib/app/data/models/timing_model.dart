// To parse this JSON data, do
//
//     final timingModel = timingModelFromJson(jsonString);

import 'dart:convert';

List<Timings> timingsFromJson(String str) =>
    List<Timings>.from(json.decode(str).map((x) => Timings.fromJson(x)));

String timingsToJson(List<Timings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Timings {
  String? id;
  String? timing;
  String? sequence;

  Timings({
    this.id,
    this.timing,
    this.sequence,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        id: json["_id"],
        timing: json["timing"],
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "timing": timing,
        "sequence": sequence,
      };
}
