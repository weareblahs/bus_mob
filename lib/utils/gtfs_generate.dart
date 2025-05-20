import 'dart:convert';

import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/data/models/bus_trip_map.dart';
import 'package:flutter/material.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:http/http.dart' as http;
import 'package:osm_nominatim/osm_nominatim.dart';

Future<List<BusBasicInfo>> generateGtfs(String provider, String route) async {
  final providerList = await http.get(
    Uri.parse(
      'https://github.com/weareblahs/bus/raw/refs/heads/main/app/src/internalData/providers.json',
    ),
  );
  if (providerList.statusCode == 200) {
    // final pl = json
    //     .decode(providerList.body)
    //     .where((p) => p?['providerName'] == provider);
    // debugPrint(pl.toString());
    final url = Uri.parse(
      'https://api.data.gov.my/gtfs-realtime/vehicle-position/prasarana?category=rapid-bus-penang',
    );
    final response = await http.get(url);
    // get from trip id
    // QUICK NOTE: the following URL is already static. for the original React instance, this file is compiled
    // when there is an update from GitHub, this will also auto update, too
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
    }

    final foundTripsForRoute = trips.where((t) => t.name == route);

    if (response.statusCode == 200) {
      final feedMessage = FeedMessage.fromBuffer(response.bodyBytes);
      List<BusBasicInfo> finalResult = [];
      for (final bus in feedMessage.entity) {
        for (final r in foundTripsForRoute) {
          if (r.id == bus.vehicle.trip.tripId) {
            final reverseSearchResult = await Nominatim.reverseSearch(
              lat: bus.vehicle.position.latitude,
              lon: bus.vehicle.position.longitude,
              addressDetails: true,
              extraTags: false,
              nameDetails: false,
              language: 'ms',
            );

            //debugPrint(bus.vehicle.vehicle.licensePlate);
            finalResult.add(
              BusBasicInfo(
                licensePlate: bus.vehicle.vehicle.licensePlate,
                latitude: bus.vehicle.position.latitude,
                longitude: bus.vehicle.position.longitude,
                speed: bus.vehicle.position.speed,
                currentParsedLocation:
                    "${(reverseSearchResult.address?['road'] != null) ? "${reverseSearchResult.address?['road']}, " : ""}${(reverseSearchResult.address?['suburb'] != null) ? "${reverseSearchResult.address?['suburb']}, " : ""}${(reverseSearchResult.address?['city'] != null) ? "${reverseSearchResult.address?['city']}, " : ""}",
              ),
            );
          }
        }
      }
      return finalResult;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
  throw Exception("Provider fetching failed.");
}
