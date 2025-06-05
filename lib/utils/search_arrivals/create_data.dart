import 'package:bus_mob/data/models/arrivals.dart';
import 'package:bus_mob/utils/find_osrm_duration_and_distance.dart';
import 'package:bus_mob/utils/get_nearest_stations.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';

Future<Arrivals?> createArrivalData(
  FeedEntity bus,
  int sequence,
  double stnLat,
  double stnLon,
  String route,
) async {
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
  );

  // Check if currentStationSequence is not null and not NaN
  if (data2.currentStationSequence != null &&
      !data2.currentStationSequence!.isNaN) {
    final dist = sequence - data2.currentStationSequence!;
    return Arrivals(
      licensePlate: bus.vehicle.vehicle.licensePlate,
      duration: data.duration,
      distance: data.distance,
      isLeft: dist > 0,
      stopsAway: dist,
      busLat: bus.vehicle.position.latitude,
      busLon: bus.vehicle.position.longitude,
      route: route,
      seq: sequence,
    );
  }
  return null;
}
