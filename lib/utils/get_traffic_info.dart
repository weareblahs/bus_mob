import '../data/repo/repo.dart';

Future<String?> getTrafficInfoText(int current, String route) async {
  final data = await getInfo(current, route);
  if (data.isEmpty) {
    return null;
  }
  switch (data[0].infoType) {
    case "trafficJam":
      return "User report: Traffic jam between roads of this bus. Do expect delays.";
    case "accident":
      return "User report: Accident happened between roads of this bus. Do expect delays.";
    default:
      return null;
  }
}
