// To parse this JSON data, do
//
//     final cityLocation = cityLocationFromJson(jsonString);

import 'dart:convert';

List<String> cityLocationFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String cityLocationToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
