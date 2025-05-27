class Information {
  String? routeId;
  String? fromSeqNo;
  String? toSeqNo;
  String? infoType;
  String? userId;

  Information({
    this.routeId,
    this.fromSeqNo,
    this.toSeqNo,
    this.infoType,
    this.userId,
  });

  Information.fromJson(Map<String, dynamic> json) {
    routeId = json['routeId'];
    fromSeqNo = json['fromSeqNo'].toString();
    toSeqNo = json['toSeqNo'].toString();
    infoType = json['infoType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['routeId'] = routeId;
    data['fromSeqNo'] = fromSeqNo;
    data['toSeqNo'] = toSeqNo;
    data['infoType'] = infoType;
    data['userId'] = userId;
    return data;
  }
}
