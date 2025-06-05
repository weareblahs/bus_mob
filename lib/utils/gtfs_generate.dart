import 'package:bus_mob/utils/gtfs_generate/create_data.dart';
import 'package:bus_mob/utils/gtfs_generate/get_found_trips.dart';
import 'package:bus_mob/utils/gtfs_generate/get_gtfs_data.dart';
import '../data/models/bus_basic_info.dart';
import 'variables.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';

Future<List<BusBasicInfo>?> generateGtfs(
  String provider,
  String route,
  Function updateMsg,
) async {
  List<BusBasicInfo> finalResult = [];
  updateMsg(busSearchStart);
  final gtfsData = await getGtfsData();

  try {
    final feedMessage = FeedMessage.fromBuffer(gtfsData!);
    final foundTripsForRoute = await getFoundTrips(provider, updateMsg, route);

    if (foundTripsForRoute != null) {
      for (final bus in feedMessage.entity) {
        for (final r in foundTripsForRoute) {
          if (r.id == bus.vehicle.trip.tripId) {
            final busInfo = await createData(bus, route);
            finalResult.add(busInfo);
            updateMsg(busUpdated(finalResult.length));
          }
        }
      }
    }
    return finalResult;
  } catch (e) {
    return null;
  }
}
