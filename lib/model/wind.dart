class Wind{
  double? speed;
  int? deg;

  Wind({ this.speed,  this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] as double,
      deg: json["deg"],
    );
  }

}