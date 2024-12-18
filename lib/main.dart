import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:weather_app/utils/home_binding.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/app_localization.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SemanticsService.announce("Firebase initialized ", TextDirection.ltr);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var local in supportedLocales) {
          if (deviceLocal != null &&
              local.languageCode == deviceLocal.languageCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        )
      ],
    );
  }
}
