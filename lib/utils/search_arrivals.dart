import 'package:bus_mob/data/models/arrivals.dart';
import 'package:bus_mob/utils/gtfs_generate/get_found_trips.dart';
import 'package:bus_mob/utils/gtfs_generate/get_gtfs_data.dart';
import 'package:bus_mob/utils/search_arrivals/create_data.dart';
import 'package:bus_mob/utils/search_arrivals/get_station_data.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<List<Arrivals>> searchArrivals(int sequence, String route) async {
  List<Arrivals> result = [];
  final config = Hive.box('busConfig');
  double stnLat = 0.0;
  double stnLon = 0.0;
  final foundTripsForRoute = await getFoundTrips(
    config.get("provider"),
    () {},
    route,
  );
  final currentStationInfo = await getStationData(sequence);
  if (currentStationInfo != null) {
    stnLat = double.parse(currentStationInfo.stopLat!);
    stnLon = double.parse(currentStationInfo.stopLon!);
  }
  final gtfsData = await getGtfsData();
  if (gtfsData != null) {
    final feedMessage = FeedMessage.fromBuffer(gtfsData);
    if (foundTripsForRoute != null) {
      for (final bus in feedMessage.entity) {
        for (final r in foundTripsForRoute) {
          if (r.id == bus.vehicle.trip.tripId) {
            final data = await createArrivalData(
              bus,
              sequence,
              stnLat,
              stnLon,
              route,
            );
            if (data != null) {
              result.add(data);
            }
          }
        }
      }
    }
  }
  return result;
}
