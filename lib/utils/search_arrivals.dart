import 'dart:convert';
import 'package:bus_mob/data/models/arrivals.dart';
import 'package:bus_mob/data/models/bus_trip_map.dart';
import 'package:bus_mob/data/models/station_data.dart';
import 'package:bus_mob/utils/find_osrm_duration_and_distance.dart';
import 'package:bus_mob/utils/get_nearest_stations.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<Arrivals>> searchArrivals(int sequence, String route) async {
  List<Arrivals> result = [];
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
    double stnLat = -1.0;
    double stnLon = -1.0;
    // before parsing, grab station latitude and longitude

    final stnData = await http.get(
      Uri.parse(
        "https://b.ntyx.dev/data/stnInfo/${config.get("provider")}_$route.json",
      ),
    );
    if (stnData.statusCode == 200) {
      for (final stn in json.decode(stnData.body)) {
        final data = StationData.fromJson(stn);
        if (int.parse(data.stopSequence!) == sequence) {
          stnLat = double.parse(data.stopLat!);
          stnLon = double.parse(data.stopLon!);
        }
      }

      if (tripData.statusCode == 200) {
        for (var item in json.decode(tripData.body)) {
          if (item?['providerName'] == config.get("provider")) {
            for (var trip in item["trips"]) {
              trips.add(Trips.fromJson(trip));
            }
          }
        }
        final foundTripsForRoute = trips.where((t) => t.name == route);

        final feedMessage = FeedMessage.fromBuffer(response.bodyBytes);
        for (final bus in feedMessage.entity) {
          for (final r in foundTripsForRoute) {
            if (r.id == bus.vehicle.trip.tripId) {
              // check if the bus is beyond the distance or something let's see
              final data = await getOsrmData(
                bus.vehicle.position.latitude,
                bus.vehicle.position.longitude,
                stnLat,
                stnLon,
              );
              final data2 = await getNearestStations(
                bus.vehicle.position.latitude,
                bus.vehicle.position.longitude,
                route,
              ); // get current estimated bus position and compare with current station number to identify if it left the station or if it is arriving soon

              if (!data2.currentStationSequence!.isNaN) {
                final dist = sequence - data2.currentStationSequence!;
                result.add(
                  Arrivals(
                    licensePlate: bus.vehicle.vehicle.licensePlate,
                    duration: data.duration,
                    distance: data.distance,
                    isLeft: dist > 0,
                    stopsAway: dist,
                    busLat: bus.vehicle.position.latitude,
                    busLon: bus.vehicle.position.longitude,
                    route: route,
                    seq: sequence,
                  ),
                );
              }
            }
          }
        }
      }
    }
  }
  return result;
}
