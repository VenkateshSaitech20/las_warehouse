// To parse this JSON data, do
//
//     final citiesmodel = citiesmodelFromJson(jsonString);

import 'dart:convert';

List<Citiesmodel> citiesmodelFromJson(String str) => List<Citiesmodel>.from(json.decode(str).map((x) => Citiesmodel.fromJson(x)));

String citiesmodelToJson(List<Citiesmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Citiesmodel {
    String? state;
    List<String>? cities;

    Citiesmodel({
        this.state,
        this.cities,
    });

    factory Citiesmodel.fromJson(Map<String, dynamic> json) => Citiesmodel(
        state: json["state"],
        cities: json["cities"] == null ? [] : List<String>.from(json["cities"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
    };
}
