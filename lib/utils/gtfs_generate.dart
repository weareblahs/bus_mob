import 'dart:convert';

import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/data/models/bus_trip_map.dart';
import 'package:bus_mob/data/screens/home.dart';
import 'package:bus_mob/utils/get_nearest_stations.dart';
import 'package:flutter/material.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:osm_nominatim/osm_nominatim.dart';

Future<List<BusBasicInfo>> generateGtfs(String provider, String route) async {
  // this is a mirror of https://raw.githubusercontent.com/weareblahs/bus/refs/heads/main/app/src/internalData/providers.json
  // hosted on uploadthing by ping labs (uploadthing.com). the host is changed due to how android emulators, sometimes, can't
  // connect to the github version of the URL.

  final providerList = await http.get(
    Uri.parse(
      'https://i3y1zzl5dl.ufs.sh/f/Cm68qkvCYisct43FXOOL9Jy7QUzfvsLNY6lrXP85San2uoti',
    ),
  );
  if (providerList.statusCode == 200) {
    // get provider URL
    final config = Hive.box('busConfig');
    final url = Uri.parse(config.get("providerEndpointURL"));
    final response = await http.get(url);
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
              cpl =
                  "near ${(reverseSearchResult.address?['road'] != null) ? "${reverseSearchResult.address?['road']}, " : ""}${(reverseSearchResult.address?['suburb'] != null) ? "${reverseSearchResult.address?['suburb']}, " : ""}${(reverseSearchResult.address?['city'] != null) ? "${reverseSearchResult.address?['city']}" : ""}";
            } catch (e) {
              cpl =
                  "Failed to retrieve location. Do note that location can still be viewed via Google Maps with the button at the right.";
            }
            //debugPrint(bus.vehicle.vehicle.licensePlate);
            // get nearest station
            var nearest = await getNearestStations(
              bus.vehicle.position.latitude,
              bus.vehicle.position.longitude,
              route,
            );
            finalResult.add(
              BusBasicInfo(
                licensePlate: bus.vehicle.vehicle.licensePlate,
                latitude: bus.vehicle.position.latitude,
                longitude: bus.vehicle.position.longitude,
                speed: bus.vehicle.position.speed,
                currentParsedLocation: cpl,
                busStations: nearest,
              ),
            );

            config.put(
              "tempMsgData",
              "Found ${finalResult.length.toString()} bus${finalResult.length > 1 ? "es" : ""} in this route",
            );
            debugPrint(config.get("tempMsgData").toString());
          }
        }
      }
      // clear temporary message
      config.delete("tempMsgData");
      return finalResult;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
  throw Exception("Provider fetching failed.");
}
