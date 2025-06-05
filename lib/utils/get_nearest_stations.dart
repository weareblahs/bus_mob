import 'package:bus_mob/utils/get_nearest_stations/get_list_of_bus_stops.dart';
import 'package:bus_mob/utils/get_nearest_stations/get_nearby_bus_stops.dart';
import 'package:flutter/cupertino.dart';
import '../models/bus_basic_info.dart';
import '../models/bus_stop.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<BusStations> getNearestStations(
  double lat,
  double lon,
  String route,
) async {
  var config = Hive.box("busConfig");
  var provider = config.get("provider");
  var stops = await getListOfBusStops(provider, route);
  try {
    BusStop previousBusStop = BusStop();
    BusStop nextBusStop = BusStop();
    BusStop currentBusStop = BusStop();
    final nearbyBusStop = getNearbyBusStops(stops, lat, lon);
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
      currentStationSequence:
          currentBusStop.stopSequence != null
              ? int.parse(currentBusStop.stopSequence!)
              : -1,
      currentStationLat:
          currentBusStop.stopLat != null
              ? double.tryParse(currentBusStop.stopLat!)
              : -1,
      currentStationLon:
          currentBusStop.stopLon != null
              ? double.tryParse(currentBusStop.stopLon!)
              : -1,
    );
  } catch (e) {
    debugPrint("Error: $e");
    return BusStations(); // return blank
  }
}
