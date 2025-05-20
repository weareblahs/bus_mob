class BusBasicInfo {
  String? licensePlate;
  double? speed = 0.0;
  double? latitude;
  double? longitude;
  String? currentParsedLocation = "Unknown location";

  BusBasicInfo({
    required this.licensePlate,
    this.speed,
    required this.latitude,
    required this.longitude,
    this.currentParsedLocation,
  });

  @override
  String toString() {
    return "BusBasicInfo: $licensePlate, $speed, $latitude, $longitude, $currentParsedLocation";
  }
}
