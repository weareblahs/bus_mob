// the "s" is necessary

class Providers {
  String? providerName;
  String? state;
  String? country;
  String? endpoint;

  Providers({this.providerName, this.state, this.country, this.endpoint});

  Providers.fromJson(Map<String, dynamic> json) {
    providerName = json['providerName'];
    state = json['state'];
    country = json['country'];
    endpoint = json['endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['providerName'] = providerName;
    data['state'] = state;
    data['country'] = country;
    data['endpoint'] = endpoint;
    return data;
  }

  @override
  String toString() {
    return "Providers($providerName, $state, $country, $endpoint)";
  }
}
