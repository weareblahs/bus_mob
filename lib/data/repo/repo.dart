import 'package:bus_mob/data/models/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
void submitInfo(Information info) async {
  await supabase.from("bus_info").insert(info.toJson());
}

Future<List<Information>> getInfoList() async {
  final resp = await supabase.from("bus_info").select();
  print(resp.toString());
  return resp.map((map) => Information.fromJson(map)).toList();
}
