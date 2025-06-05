import 'dart:convert';

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

Future<List<BusBasicInfo>> generateGtfs(
  String provider,
  String route,
  Function updateMsg,
) async {
  updateMsg(busSearchStart);
  // get provider URL
  final config = Hive.box('busConfig');
  final url = Uri.parse(config.get("providerEndpointURL"));
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // get from trip id
    // QUICK NOTE: the following URL is already static. for the original React instance, this file is compiled
    // with the react code. when there is an update from GitHub, this will also auto update, too
    final tripData = await http.get(
      Uri.parse(
        'https://github.com/weareblahs/bus/raw/refs/heads/main/app/src/internalData/trips.json',
      ),
    );
    List<Trips> trips = [];
    if (tripData.statusCode == 200) {
      for (var item in json.decode(tripData.body)) {
        if (item?['providerName'] == provider) {
          for (var trip in item["trips"]) {
            trips.add(Trips.fromJson(trip));
          }
        }
      }
    } else {
      updateMsg("An error occured. Status code: ${tripData.statusCode}");
    }
    final foundTripsForRoute = trips.where((t) => t.name == route);

    if (response.statusCode == 200) {
      final feedMessage = FeedMessage.fromBuffer(response.bodyBytes);
      List<BusBasicInfo> finalResult = [];
      for (final bus in feedMessage.entity) {
        for (final r in foundTripsForRoute) {
          var cpl = "";
          if (r.id == bus.vehicle.trip.tripId) {
            try {
              final reverseSearchResult = await Nominatim.reverseSearch(
                lat: bus.vehicle.position.latitude,
                lon: bus.vehicle.position.longitude,
                addressDetails: true,
                extraTags: false,
                nameDetails: false,
                language: 'ms',
              );
              cpl = osmMessage(reverseSearchResult);
            } catch (e) {
              cpl = osmErrorMsg;
            }
            // get nearest station
            var nearest = await getNearestStations(
              bus.vehicle.position.latitude,
              bus.vehicle.position.longitude,
              route,
            );
            String? trafficText;
            if (nearest.currentStationSequence != null) {
              trafficText = await getTrafficInfoText(
                nearest.currentStationSequence!,
                route,
              );
            }
            var osrmData = OsrmData();
            if (nearest.currentStationLat != null &&
                nearest.currentStationLon != null) {
              osrmData = await getOsrmData(
                bus.vehicle.position.latitude,
                bus.vehicle.position.longitude,
                nearest.currentStationLat!,
                nearest.currentStationLon!,
              );
            }
            finalResult.add(
              BusBasicInfo(
                licensePlate: bus.vehicle.vehicle.licensePlate,
                latitude: bus.vehicle.position.latitude,
                longitude: bus.vehicle.position.longitude,
                speed: bus.vehicle.position.speed,
                currentParsedLocation: cpl,
                busStations: nearest,
                trafficInfo: trafficText,
                osrmData: osrmData,
              ),
            );
            updateMsg(busUpdated(finalResult.length));
          }
        }
      }
      // clear temporary message
      config.delete("tempMsgData");
      finalResult.sort((a, b) => a.licensePlate!.compareTo(b.licensePlate!));
      return finalResult;
    } else {
      if (response.statusCode != 200) {
        updateMsg(
          json.decode(response.body)['detail'],
        ); // assuming if it is using data.gov.my API then the detail text should be here
      }
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
  throw Exception("Provider fetching failed.");
}
