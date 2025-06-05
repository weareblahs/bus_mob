import 'package:bus_mob/models/bus_stop.dart';
import 'package:bus_mob/utils/distance.dart';

List<BusStop> getNearbyBusStops(List<BusStop> stops, double lat, double lon) {
  List<BusStop> nearbyBusStop = [];
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
  return nearbyBusStop;
}
