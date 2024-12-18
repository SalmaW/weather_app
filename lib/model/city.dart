import 'coord.dart';

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone,
        this.sunrise,
        this.sunset});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.parse(json["id"]),
      name: json["name"],
      coord: Coord.fromJson(json["coord"]),
      country: json["country"],
      population: int.parse(json["population"]),
      timezone: int.parse(json["timezone"]),
      sunrise: int.parse(json["sunrise"]),
      sunset: int.parse(json["sunset"]),
    );
  }
}