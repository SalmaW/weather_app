import 'package:permission_handler/permission_handler.dart';

class ModularPermissionManager {
  ModularPermissionManager._privateConstructor();

  static final ModularPermissionManager _instance =
      ModularPermissionManager._privateConstructor();

  factory ModularPermissionManager() {
    return _instance;
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  // Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }
}
