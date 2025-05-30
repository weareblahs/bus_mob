import 'dart:convert';

import '../data/models/providers.dart';
import 'package:http/http.dart' as http;

Future<List<Providers>> getProviders() async {
  final providerList = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/weareblahs/bus/refs/heads/main/app/src/internalData/providers.json',
    ),
  );
  final jsonData = json.decode(providerList.body);
  List<Providers> result = [];
  for (var d in jsonData) {
    result.add(Providers.fromJson(d));
  }
  return result;
}
