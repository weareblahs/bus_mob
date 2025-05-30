import 'dart:convert';

import '../data/models/station_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<List<DropdownMenuEntry>> getProviderStations(String route) async {
  final config = Hive.box("busConfig");
  var provider = config.get("provider");
  var res = await http.get(
    Uri.parse("https://b.ntyx.dev/data/stnInfo/${provider}_$route.json"),
  );
  List<DropdownMenuEntry> stations = [];
  if (res.statusCode == 200) {
    var jsonRes = json.decode(res.body);

    for (var r in jsonRes) {
      var converted = StationData.fromJson(r);
      stations.add(
        DropdownMenuEntry(
          value: "${converted.stopSequence}",
          label: "${converted.stopName}",
        ),
      );
    }
  }
  return stations;
}

Future<List<String>> getRouteRange(String route, String from, String to) async {
  List<String> range = [];
  int fromInt = int.parse(from);
  int toInt = int.parse(to);
  List<DropdownMenuEntry> listOfStations = await getProviderStations(route);
  for (int i = fromInt - 1; i < toInt; i++) {
    range.add(listOfStations[i].label);
  }
  return range;
}
