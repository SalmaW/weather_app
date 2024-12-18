import 'package:weather_app/model/clouds.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/main_waether.dart';
import 'package:weather_app/model/sys.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/model/wind.dart';

class CurrentWeatherData{
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final Wind? wind;
  final int? visibility;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeatherData({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.wind,
    this.visibility,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeatherData.fromJson(dynamic json) {
    if (json == null) {
      return CurrentWeatherData();
    }

    return CurrentWeatherData(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: (json['weather'] as List?)
          ?.map((w) => Weather.fromJson(w))
          .toList(),
      base: json['base'],
      main: json['main'] != null ? MainWeather.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}