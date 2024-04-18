import 'dart:convert';

class Location {
  Location({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  final String name;
  final String country;
  final num lat;
  final num lon;

  String toJson() => json.encode(
        <String, dynamic>{
          'name': name,
          'country': country,
          'lat': lat,
          'lon': lon,
        },
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'] as String,
        country: json['country'] as String,
        lat: json['lat'] as num,
        lon: json['lon'] as num,
      );
}
