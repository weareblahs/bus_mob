import 'dart:convert';
import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/data/models/bus_stop.dart';
import 'package:bus_mob/utils/distance.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

Future<BusStations> getNearestStations(
  double lat,
  double lon,
  String route,
) async {
  var config = Hive.box("busConfig");
  var provider = config.get("provider");

  final stationList = await http.get(
    Uri.parse("https://b.ntyx.dev/data/stnInfo/${provider}_$route.json"),
  );
  List<BusStop> stops = [];
  final busStopJson = json.decode(stationList.body);
  for (final b in busStopJson) {
    stops.add(BusStop.fromJson(b));
  }
  List<BusStop> nearbyBusStop = [];
  var previousBusStop = BusStop();
  var nextBusStop = BusStop();
  var currentBusStop = BusStop();
  for (final s in stops) {
    if (distance(
          lat.toDouble(),
          lon.toDouble(),
          double.parse(s.stopLat!),
          double.parse(s.stopLon!),
          "K",
        ) <=
        0.8) {
      nearbyBusStop.add(s);
    }
  }
  // previous station

  if (nearbyBusStop.isNotEmpty) {
    switch (nearbyBusStop.length) {
      case 1:
        {
          if (nearbyBusStop[0].stopSequence! == "1") {
            previousBusStop = BusStop(stopName: "First station");
          } else {
            previousBusStop =
                stops[int.parse(nearbyBusStop[0].stopSequence!) - 1];
          }
          currentBusStop = nearbyBusStop[0];
          nextBusStop = BusStop(stopName: "Unknown station");
        }
      case 2:
        {
          if (nearbyBusStop[0].stopSequence! == "1") {
            previousBusStop = BusStop(stopName: "First station");
          } else {
            previousBusStop =
                stops[int.parse(nearbyBusStop[0].stopSequence!) - 1];
          }
          currentBusStop = nearbyBusStop[1];
          nextBusStop = stops[int.parse(nearbyBusStop[1].stopSequence!) - 1];
        }
      case 3:
        {
          if (nearbyBusStop[0].stopSequence! == "1") {
            previousBusStop = BusStop(stopName: "First station");
          } else {
            previousBusStop = nearbyBusStop[0];
          }
          currentBusStop = nearbyBusStop[1];
          nextBusStop = nearbyBusStop[2];
        }
      default:
        {
          if (nearbyBusStop[0].stopSequence! == "1") {
            previousBusStop = BusStop(stopName: "First station");
          } else {
            previousBusStop = nearbyBusStop[1];
          }
          currentBusStop = nearbyBusStop[2];
          nextBusStop = nearbyBusStop[3];
        }
    }
  }

  print(
    BusStations(
      previousStation:
          previousBusStop != BusStop()
              ? previousBusStop.stopName ?? "First station"
              : "Unknown station",
      currentStation:
          currentBusStop != BusStop()
              ? currentBusStop.stopName ?? "Unknown station"
              : "Unknown station",
      nextStation:
          nextBusStop != BusStop()
              ? nextBusStop.stopName ?? "Last station"
              : "Unknown station",
    ),
  );
  return BusStations(
    previousStation:
        previousBusStop != BusStop()
            ? previousBusStop.stopName ?? "First station"
            : "Unknown station",
    currentStation:
        currentBusStop != BusStop()
            ? currentBusStop.stopName ?? "Unknown station"
            : "Unknown station",
    nextStation:
        nextBusStop != BusStop()
            ? nextBusStop.stopName ?? "Last station"
            : "Unknown station",
  );
}
