import 'dart:convert';

import 'package:bus_mob/data/models/providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Providers>> getProviders() async {
  // this is a mirror of https://raw.githubusercontent.com/weareblahs/bus/refs/heads/main/app/src/internalData/providers.json
  // hosted on uploadthing by ping labs (uploadthing.com). the host is changed due to how android emulators, sometimes, can't
  // connect to the github version of the URL.
  final providerList = await http.get(
    Uri.parse(
      'https://i3y1zzl5dl.ufs.sh/f/Cm68qkvCYisct43FXOOL9Jy7QUzfvsLNY6lrXP85San2uoti',
    ),
  );
  final jsonData = json.decode(providerList.body);
  List<Providers> result = [];
  for (var d in jsonData) {
    result.add(Providers.fromJson(d));
  }
  return result;
}
