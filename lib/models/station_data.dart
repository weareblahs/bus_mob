class StationData {
  String? stopName;
  String? stopLat;
  String? stopLon;
  String? stopId;
  String? stopSequence;

  StationData({
    this.stopName,
    this.stopLat,
    this.stopLon,
    this.stopId,
    this.stopSequence,
  });

  StationData.fromJson(Map<String, dynamic> json) {
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
