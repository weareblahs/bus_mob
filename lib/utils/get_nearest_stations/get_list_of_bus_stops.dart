import 'dart:convert';

import 'package:bus_mob/models/bus_stop.dart';
import 'package:http/http.dart' as http;

Future<List<BusStop>> getListOfBusStops(String provider, String route) async {
  final stationList = await http.get(
    Uri.parse("https://b.ntyx.dev/data/stnInfo/${provider}_$route.json"),
  );
  List<BusStop> stops = [];
  final busStopJson = json.decode(stationList.body);
  for (final b in busStopJson) {
    stops.add(BusStop.fromJson(b));
  }
  return stops;
}
