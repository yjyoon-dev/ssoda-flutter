class Address {
  final String city;
  final String country;
  final String town;
  final String road;
  final String building;
  final String zipCode;
  final double? latitude;
  final double? longitude;

  Address(
      {required this.city,
      required this.country,
      required this.town,
      required this.road,
      required this.building,
      required this.zipCode,
      required this.latitude,
      required this.longitude});

  String getFullAddress() {
    return '${this.city} ${this.country} ${this.road} ${this.building}';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        city: json['city'],
        country: json['country'],
        town: json['town'],
        road: json['road'],
        building: json['buildingCode'],
        zipCode: json['zipCode'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}
