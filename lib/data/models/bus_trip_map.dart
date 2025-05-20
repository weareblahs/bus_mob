import 'package:flutter/material.dart';

class BusTripMap {
  String? providerName;
  List<Trips>? trips;

  BusTripMap({this.providerName, this.trips});

  BusTripMap.fromJson(dynamic json) {
    providerName = json['providerName'];
    debugPrint(providerName);
    if (json['trips'] != null) {
      trips = <Trips>[];
      json['trips'].forEach((v) {
        trips!.add(Trips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerName'] = this.providerName;
    if (this.trips != null) {
      data['trips'] = this.trips!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Trips($id, $name)";
  }
}
