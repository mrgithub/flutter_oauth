class Provider {
  String display_name; //	Display name for the Provider
  String logo_uri; //		Uri for the Provider logo
  String provider_id; //	Unique identifier for the Provider

  Provider({this.display_name, this.logo_uri, this.provider_id});

  factory Provider.fromJson(Map<String, dynamic> parsedJson) {
    return Provider(
        display_name: parsedJson['display_name'],
        logo_uri: parsedJson['logo_uri'],
        provider_id: parsedJson['provider_id']);
  }
}
