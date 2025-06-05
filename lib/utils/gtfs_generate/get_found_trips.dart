import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bus_mob/data/models/bus_trip_map.dart';

Future<List?> getFoundTrips(
  String provider,
  Function updateMsg,
  String route,
) async {
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
  final filtered = trips.where((t) => t.name == route);
  return filtered.toList();
}
