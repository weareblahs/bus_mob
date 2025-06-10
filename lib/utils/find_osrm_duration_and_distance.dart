import 'dart:convert';

import 'package:bus_mob/models/ors_data.dart';
import 'package:bus_mob/models/osrm_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// Future<OsrmData> getOsrmData(
//   double lat1,
//   double lon1,
//   double lat2,
//   double lon2,
// ) async {
//   final osrmUri = Uri.parse(
//     "https://router.project-osrm.org/route/v1/driving/$lon1,$lat1;$lon2,$lat2?overview=false",
//   );
//   final osrmReq = await http.get(osrmUri);
//   if (osrmReq.statusCode == 200) {
//     return OsrmData.fromJson(json.decode(osrmReq.body));
//   }
//   return OsrmData();
// }

Future<OrsData> getOrsData(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) async {
  final orsApiKey = dotenv.env['ORS_API_KEY'];
  final orsUri = Uri.parse(
    "https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=$lon1,$lat1&end=$lon2,$lat2",
  );
  final orsReq = await http.get(orsUri);
  if (orsReq.statusCode == 200) {
    // so basically this is the weirdest temporary solution i can think
    return OrsData(
      distance:
          json.decode(
            orsReq.body,
          )['features'][0]['properties']['summary']['distance'],
      duration:
          json.decode(
            orsReq.body,
          )['features'][0]['properties']['summary']['duration'] *
          2.2,
    );
  }
  return OrsData();
}
