import 'package:get/get.dart';
import '/model/current_weather_data.dart';
import '/model/five_days_data.dart';
import '/service/weather_service.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDaysData> fiveDaysData = [];

  HomeController({required this.city});

  @override
  void onInit() {
    initState();
    getTopFiveCities();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  Future<void> getCurrentWeatherData() async {
    try {
      WeatherService(city: "$city").getCurrentWeatherData(
        onSuccess: (data) {
          currentWeatherData = data;
          update();
        },
        onError: (error) {
          print("home_controller getCurrentWeatherData $error");
          Get.snackbar('Error', 'Failed to fetch weather data');
          update();
        },
      );
    } catch (e) {
      print("home_controller getCurrentWeatherData unexpected error: $e");
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }

  void getTopFiveCities() {
    List<String> cities = [
      'zagazig',
      'cairo',
      'alexandria',
      'ismailia',
      'fayoum'
    ];
    for (var c in cities) {
      WeatherService(city: c).getCurrentWeatherData(
        onSuccess: (data) {
          dataList.add(data);
          update();
        },
        onError: (error) {
          print("home_controller getTopFiveCities $error");
          update();
        },
      );
    }
  }

  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveThreeHourForecastData(
      onSuccess: (data) {
        fiveDaysData = data;
        update();
      },
      onError: (error) {
        print("home_controller getFiveDaysData $error");
        update();
      },
    );
  }
}
