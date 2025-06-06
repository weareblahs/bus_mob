// Model based on https://b.ntyx.dev/data/stnInfo/rapidPenang_801A.json, which is a mirror of the original JSON file that exists in the original bus? repository
// will use this to filter bus stops
class BusStop {
  String? stopName;
  String? stopLat;
  String? stopLon;
  String? stopId;
  String? stopSequence;

  BusStop({
    this.stopName,
    this.stopLat,
    this.stopLon,
    this.stopId,
    this.stopSequence,
  });

  BusStop.fromJson(Map<String, dynamic> json) {
    stopName = json['stop_name'];
    stopLat = json['stop_lat'];
    stopLon = json['stop_lon'];
    stopId = json['stop_id'];
    stopSequence = json['stop_sequence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_name'] = stopName;
    data['stop_lat'] = stopLat;
    data['stop_lon'] = stopLon;
    data['stop_id'] = stopId;
    data['stop_sequence'] = stopSequence;
    return data;
  }
}
