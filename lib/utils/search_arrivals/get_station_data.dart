import 'dart:convert';

import 'package:bus_mob/data/models/station_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

Future<StationData?> getStationData(int sequence) async {
  // route and provider are already in storage
  final config = Hive.box("busConfig");
  final stnData = await http.get(
    Uri.parse(
      "https://b.ntyx.dev/data/stnInfo/${config.get("provider")}_${config.get("route")}.json",
    ),
  );
  if (stnData.statusCode == 200) {
    for (final stn in json.decode(stnData.body)) {
      final data = StationData.fromJson(stn);
      if (int.parse(data.stopSequence!) == sequence) {
        return StationData.fromJson(stn);
      }
    }
  }
  return null;
}
