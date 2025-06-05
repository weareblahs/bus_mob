import 'package:bus_mob/utils/variables.dart';

import '../data/repo/repo.dart';

Future<String?> getTrafficInfoText(int current, String route) async {
  final data = await getInfo(current, route);
  if (data.isEmpty) {
    return null;
  }
  switch (data[0].infoType) {
    case "trafficJam":
      return trafficJamNotificationMessage;
    case "accident":
      return accidentNotificationMessage;
    default:
      return null;
  }
}

Future<String?> getTrafficInfoTextCompact(int current, String route) async {
  final data = await getInfo(current, route);
  if (data.isEmpty) {
    return null;
  }
  switch (data[0].infoType) {
    case "trafficJam":
      return "Expect delays: Traffic jam";
    case "accident":
      return "Expect delays: Traffic accident";
    default:
      return "";
  }
}
