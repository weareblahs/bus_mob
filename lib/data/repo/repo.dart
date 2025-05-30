import '../models/information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
void submitInfo(Information info) async {
  await supabase.from("bus_info").insert(info.toJson());
}

Future<List<Information>> getInfoList() async {
  final resp = await supabase.from("bus_info").select();
  return resp.map((map) => Information.fromJson(map)).toList();
}

void deleteInfo(Information info) async {
  await supabase.from("bus_info").delete().eq("uuid", info.uuid!);
}

Future<List<Information>> getInfo(int currentStation, String route) async {
  final resp = await supabase.from("bus_info").select().eq("route_id", route);
  final converted = resp.map((map) => Information.fromJson(map)).toList();
  List<Information> sortedInfo = [];
  for (final s in converted) {
    if (int.parse(s.fromSeqNo!) >= currentStation ||
        currentStation <= int.parse(s.toSeqNo!)) {
      sortedInfo.add(s);
    }
  }
  return sortedInfo;
}
