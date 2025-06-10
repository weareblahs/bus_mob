class OrsData {
  double? duration;
  double? distance;

  OrsData({this.duration, this.distance});

  OrsData.fromJson(Map<String, dynamic> jsonData) {
    // conversion
    var tempDuration = -1.0;
    var tempDistance = -1.0;
    if (jsonData['code'] == "Ok") {
      tempDuration =
          jsonData['features'][0]['properties']['summary']['duration']
                      .runtimeType ==
                  double
              ? jsonData['features'][0]['properties']['summary']['duration']
              : jsonData['features'][0]['properties']['summary']['duration']
                  .toDouble();
      tempDistance =
          jsonData['features'][0]['properties']['summary']['distance']
                      .runtimeType ==
                  double
              ? jsonData['features'][0]['properties']['summary']['distance']
              : jsonData['features'][0]['properties']['summary']['distance']
                  .toDouble();
    }
    // both are inflated to reflect the arrival time from a perspective of a public transport, which the OSRM request is only available for car routing.
    // an implementation with public transportation routes might be coming soon
    duration = tempDuration * 2.2;
    distance = tempDistance;
  }

  @override
  String toString() {
    return "OrsData($duration, $distance)";
  }
}
