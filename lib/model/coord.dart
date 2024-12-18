class Coord{
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json["lon"],
      lat: json["lat"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lon": lon,
      "lat": lat,
    };
  }
}