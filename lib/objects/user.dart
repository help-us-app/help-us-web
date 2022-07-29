class User {
  String id;
  String merchantId;
  String locationId;
  String accessToken;
  String refreshToken;
  String expiresIn;

  User(
      {this.id,
      this.merchantId,
      this.locationId,
      this.accessToken,
      this.refreshToken,
      this.expiresIn});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    locationId = json['location_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['location_id'] = locationId;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    return data;
  }
}
