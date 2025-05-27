class BusBasicInfo {
  String? licensePlate;
  double? speed = 0.0;
  double? latitude;
  double? longitude;
  String? currentParsedLocation = "Unknown location";
  BusStations? busStations = BusStations();
  String? trafficInfo = "";

  BusBasicInfo({
    required this.licensePlate,
    this.speed,
    required this.latitude,
    required this.longitude,
    this.currentParsedLocation,
    this.busStations,
    this.trafficInfo,
  });

  @override
  String toString() {
    return "BusBasicInfo: $licensePlate, $speed, $latitude, $longitude, $currentParsedLocation, $busStations, $trafficInfo";
  }
}

class BusStations {
  String? previousStation = "Unknown Station";
  String? currentStation = "Unknown Station";
  String? nextStation = "Unknown Station";
  double? distanceToCurrent = -1;
  double? timeRemaining = -1;
  int? currentStationSequence = -1;

  BusStations({
    this.previousStation,
    this.currentStation,
    this.nextStation,
    this.distanceToCurrent,
    this.timeRemaining,
    this.currentStationSequence,
  });

  @override
  String toString() {
    return "BusStations($previousStation, $currentStation, $nextStation, $distanceToCurrent, $timeRemaining, $currentStationSequence)";
  }
}
