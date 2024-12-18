class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.seaLevel,
        this.grndLevel,
        this.humidity,
        this.tempKf});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: double.parse(json["temp"]),
      feelsLike: double.parse(json["feelsLike"]),
      tempMin: double.parse(json["tempMin"]),
      tempMax: double.parse(json["tempMax"]),
      pressure: int.parse(json["pressure"]),
      seaLevel: int.parse(json["seaLevel"]),
      grndLevel: int.parse(json["grndLevel"]),
      humidity: int.parse(json["humidity"]),
      tempKf: double.parse(json["tempKf"]),
    );
  }
}