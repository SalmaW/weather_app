import 'package:get/get.dart';
import 'package:weather_app/controller/home_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/service/permissions.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(city: 'zagazig'));
  }

  Future<HomeController> initializeHomeController() async {
    final permissionManager = ModularPermissionManager();
    final hasPermission = await permissionManager.requestLocationPermission();

    if (hasPermission) {
      try {
        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );

        final placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          final city = placemarks.first.locality ?? '';
          return HomeController(city: city);
        }
      } catch (e) {
        print('Error getting location: $e');
      }
    }

    return HomeController(city: 'cairo');
  }
}
