class Wind{
  final double? speed;
  final int? deg;

  Wind({ this.speed,  this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
    );
  }

}