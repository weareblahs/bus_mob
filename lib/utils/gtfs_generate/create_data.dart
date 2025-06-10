import 'package:bus_mob/models/bus_basic_info.dart';
import 'package:bus_mob/models/ors_data.dart';
import 'package:bus_mob/models/osrm_data.dart';
import 'package:bus_mob/utils/find_osrm_duration_and_distance.dart';
import 'package:bus_mob/utils/get_nearest_stations.dart';
import 'package:bus_mob/utils/get_traffic_info.dart';
import 'package:bus_mob/utils/variables.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

Future<BusBasicInfo> createData(FeedEntity bus, String route) async {
  var cpl = "";
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
  var orsData = OrsData();
  if (nearest.currentStationLat != null && nearest.currentStationLon != null) {
    orsData = await getOrsData(
      bus.vehicle.position.latitude,
      bus.vehicle.position.longitude,
      nearest.currentStationLat!,
      nearest.currentStationLon!,
    );
  }
  return BusBasicInfo(
    licensePlate: bus.vehicle.vehicle.licensePlate,
    latitude: bus.vehicle.position.latitude,
    longitude: bus.vehicle.position.longitude,
    speed: bus.vehicle.position.speed,
    currentParsedLocation: cpl,
    busStations: nearest,
    trafficInfo: trafficText,
    orsData: orsData,
  );
}
