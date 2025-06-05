class Information {
  String? routeId;
  String? fromSeqNo;
  String? toSeqNo;
  String? infoType;
  String? userId;
  String? uuid;

  Information({
    this.routeId,
    this.fromSeqNo,
    this.toSeqNo,
    this.infoType,
    this.userId,
    this.uuid,
  });

  Information.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    fromSeqNo = json['from_seq_no'].toString();
    toSeqNo = json['to_seq_no'].toString();
    infoType = json['info_type'];
    userId = json['user_id'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['route_id'] = routeId;
    data['from_seq_no'] = fromSeqNo;
    data['to_seq_no'] = toSeqNo;
    data['info_type'] = infoType;
    data['user_id'] = userId;
    data['uuid'] = uuid;
    return data;
  }
}
