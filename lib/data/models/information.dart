class Information {
  String? routeId;
  String? fromSeqNo;
  String? toSeqNo;
  String? infoType;
  String? userId;
  String? createdAt;

  Information({
    this.routeId,
    this.fromSeqNo,
    this.toSeqNo,
    this.infoType,
    this.userId,
    this.createdAt,
  });

  Information.fromJson(Map<String, dynamic> json) {
    routeId = json['routeId'];
    fromSeqNo = json['fromSeqNo'].toString();
    toSeqNo = json['toSeqNo'].toString();
    infoType = json['infoType'];
    userId = json['userId'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['routeId'] = routeId;
    data['fromSeqNo'] = fromSeqNo;
    data['toSeqNo'] = toSeqNo;
    data['infoType'] = infoType;
    data['userId'] = userId;
    data['created_at'] = createdAt;
    return data;
  }
}
