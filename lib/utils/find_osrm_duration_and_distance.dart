import 'dart:convert';

import 'package:bus_mob/data/models/osrm_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<OsrmData> getOsrmData(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) async {
  final osrmUri = Uri.parse(
    "https://router.project-osrm.org/route/v1/driving/$lon1,$lat1;$lon2,$lat2?overview=false",
  );
  final osrmReq = await http.get(osrmUri);
  if (osrmReq.statusCode == 200) {
    return OsrmData.fromJson(json.decode(osrmReq.body));
  }
  return OsrmData();
}
