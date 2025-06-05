import 'dart:convert';
import 'dart:typed_data';

import 'package:bus_mob/utils/gtfs_generate/create_data.dart';
import 'package:bus_mob/utils/gtfs_generate/get_found_trips.dart';

import '../data/models/bus_basic_info.dart';
import '../data/models/bus_trip_map.dart';
import '../data/models/osrm_data.dart';
import 'find_osrm_duration_and_distance.dart';
import 'get_nearest_stations.dart';
import 'get_traffic_info.dart';
import 'variables.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:osm_nominatim/osm_nominatim.dart';

Future<List<int>?> getGtfsData() async {
  final config = Hive.box('busConfig');
  final url = Uri.parse(config.get("providerEndpointURL"));
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return List.from(response.bodyBytes);
  }
  return null;
}

Future<List<BusBasicInfo>> generateGtfs(
  String provider,
  String route,
  Function updateMsg,
) async {
  updateMsg(busSearchStart);
  final gtfsData = await getGtfsData();
  final feedMessage = FeedMessage.fromBuffer(gtfsData!);
  List<BusBasicInfo> finalResult = [];
  final foundTripsForRoute = await getFoundTrips(provider, updateMsg, route);

  for (final bus in feedMessage.entity) {
    for (final r in foundTripsForRoute) {
      if (r.id == bus.vehicle.trip.tripId) {
        final busInfo = await createData(bus, route);
        if (busInfo !=
            BusBasicInfo(licensePlate: '', latitude: null, longitude: null)) {
          // check if this matches the default data. if so then don't add
          finalResult.add(busInfo);
        }
        updateMsg(busUpdated(finalResult.length));
      }
    }
  }
  return finalResult;
}
