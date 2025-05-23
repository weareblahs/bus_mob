import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

void downloadProvider() async {
  var config = Hive.box("busConfig");
  var providerName = config.get("provider");
  var providerData = await http.get(
    Uri.parse('https://b.ntyx.dev/data/$providerName.json'),
  );
  if (providerData.statusCode == 200) {
    // stores config locally (as cache)
    config.put('providerRoutes', providerData.body);
    // initialize - set to the first one when app loaded
    config.put("route", json.decode(providerData.body)[0]['id']);
  }
}
