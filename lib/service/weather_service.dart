import 'package:weather_app/api/api_repo.dart';
import 'package:weather_app/model/current_weather_data.dart';
import 'package:weather_app/model/five_days_data.dart';

class WeatherService {
  String city;

  WeatherService({required this.city});

  //https://api.openweathermap.org/data/2.5/weather?q=cairolang=ar&mode=json&appid=cfbc0c0d317772297a7fdae0f582a7dc

  //https://api.openweathermap.org/data/2.5/forecast?q=cairolang=ar&mode=json&appid=cfbc0c0d317772297a7fdae0f582a7dc

  String baseUrl = "https://api.openweathermap.org/data/2.5";
  String apiKey = "appid=cfbc0c0d317772297a7fdae0f582a7dc";

  void getCurrentWeatherData(
      {Function()? beforeSend,
      Function(CurrentWeatherData currentWeatherData)? onSuccess,
      Function(dynamic error)? onError}) {
    final url = "$baseUrl/weather?q=$city&lang=en&mode=json&$apiKey";
    ApiRepo(url: url).getData(
        beforeSend: () => {
              if (beforeSend != null) {beforeSend()}
            },
        onSuccess: (data) {
          final weatherData = CurrentWeatherData.fromJson(data);
          onSuccess?.call(weatherData);
        },
        onError: (error) => {
              if (onError != null)
                {
                  print("getCurrentWeatherData $error"),
                  onError(error),
                }
            });
  }

  void getFiveThreeHourForecastData(
      {Function()? beforeSend,
      Function(List<FiveDaysData> fiveDaysData)? onSuccess,
      Function(dynamic error)? onError}) {
    final url = "$baseUrl/forecast?q=$city&lang=en&$apiKey";
    ApiRepo(url: url).getData(
        beforeSend: () {},
        onSuccess: (data) {
          onSuccess!((data['list'] as List)
              .map((t) => FiveDaysData.fromJson(t))
              .toList());
        },
        onError: (error) => {
              if (onError != null)
                {
                  print("getFiveThreeHourForecastData $error"),
                  onError(error),
                }
            });
  }
}
