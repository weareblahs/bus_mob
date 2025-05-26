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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routeId'] = this.routeId;
    data['fromSeqNo'] = this.fromSeqNo;
    data['toSeqNo'] = this.toSeqNo;
    data['infoType'] = this.infoType;
    data['userId'] = this.userId;
    return data;
  }
}
