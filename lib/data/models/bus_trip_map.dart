import 'package:flutter/material.dart';

class BusTripMap {
  String? providerName;
  List<Trips>? trips;

  BusTripMap({this.providerName, this.trips});

  BusTripMap.fromJson(dynamic json) {
    providerName = json['providerName'];
    if (json['trips'] != null) {
      trips = <Trips>[];
      json['trips'].forEach((v) {
        trips!.add(Trips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['providerName'] = providerName;
    if (trips != null) {
      data['trips'] = trips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trips {
  String? id;
  String? name;

  Trips({this.id, this.name});

  Trips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Trips($id, $name)";
  }
}
