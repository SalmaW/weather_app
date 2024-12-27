import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_app/utils/home_binding.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/views/login_screen.dart';
import 'package:weather_app/views/sign_up.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'constants/app_localization.dart';
import 'constants/app_routes.dart';
import 'firebase_options.dart';
import 'service/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GetX controllers
  Get.put(AuthController());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    SemanticsService.announce("Firebase initialized ", TextDirection.ltr);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homeRoute,
        theme: ThemeData(
          primaryColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
          ),
        ),
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
            name: Routes.loginRoute,
            page: () => const LoginScreen(),
          ),
          GetPage(
            name: Routes.homeRoute,
            page: () => HomeScreen(),
            binding: HomeBinding(),
          ),
          GetPage(
            name: Routes.signUpRoute,
            page: () => const SignUpPage(),
          ),
        ],
      ),
    );
  }
}
