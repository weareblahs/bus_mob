import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<int>?> getGtfsData() async {
  final config = Hive.box('busConfig');
  final url = Uri.parse(config.get("providerEndpointURL"));
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return List.from(response.bodyBytes);
  }
  return null;
}
