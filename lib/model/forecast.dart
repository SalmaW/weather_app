import 'package:weather_app/model/city.dart';
import 'package:weather_app/model/main_forecast.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/model/wind.dart';
import 'clouds.dart';

class Forecast {
  String? cod;
  int? message;
  int? cnt;
  List<ListW>? list;
  City? city;

  Forecast({this.cod, this.message, this.cnt, this.list, this.city});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      cod: json["cod"],
      message: int.parse(json["message"]),
      cnt: int.parse(json["cnt"]),
      list: List<ListW>.of(json["list"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      city: City.fromJson(json["city"]),
    );
  }
}

class ListW {
  int? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Sys? sys;
  String? dtTxt;
  Rain? rain;

  ListW(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop,
      this.sys,
      this.dtTxt,
      this.rain});

  factory ListW.fromJson(Map<String, dynamic> json) {
    return ListW(
      dt: int.parse(json["dt"]),
      main: Main.fromJson(json["main"]),
      weather: List<Weather>.of(json["weather"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      clouds: Clouds.fromJson(json["clouds"]),
      wind: Wind.fromJson(json["wind"]),
      visibility: int.parse(json["visibility"]),
      pop: double.parse(json["pop"]),
      sys: Sys.fromJson(json["sys"]),
      dtTxt: json["dtTxt"],
      rain: Rain.fromJson(json["rain"]),
    );
  }
}

class Sys {
  String? pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json["pod"],
    );
  }
}

class Rain {
  double? d3h;

  Rain({this.d3h});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      d3h: double.parse(json["d3h"]),
    );
  }
}
