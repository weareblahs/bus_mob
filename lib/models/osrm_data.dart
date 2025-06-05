class OsrmData {
  double? duration;
  double? distance;

  OsrmData({this.duration, this.distance});

  OsrmData.fromJson(Map<String, dynamic> jsonData) {
    // conversion
    var tempDuration = -1.0;
    var tempDistance = -1.0;
    if (jsonData['code'] == "Ok") {
      tempDuration =
          jsonData['routes'][0]['duration'].runtimeType == double
              ? jsonData['routes'][0]['duration']
              : jsonData['routes'][0]['duration'].toDouble();
      tempDistance =
          jsonData['routes'][0]['distance'].runtimeType == double
              ? jsonData['routes'][0]['distance']
              : jsonData['routes'][0]['distance'].toDouble();
    }
    duration = tempDuration;
    distance = tempDistance;
  }

  @override
  String toString() {
    return "OsrmData($duration, $distance)";
  }
}
