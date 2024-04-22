// To parse this JSON data, do
//
//     final AmenityType = AmenityTypeFromJson(jsonString);

import 'dart:convert';

List<AmenityType> AmenityTypeFromJson(String str) => List<AmenityType>.from(json.decode(str).map((x) => AmenityType.fromJson(x)));

String AmenityTypeToJson(List<AmenityType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AmenityType {
    String? id;
    String? amenity;

    AmenityType({
        this.id,
        this.amenity,
    });

    factory AmenityType.fromJson(Map<String, dynamic> json) => AmenityType(
        id: json["_id"],
        amenity: json["amenity"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "amenity": amenity,
    };
}
