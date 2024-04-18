import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/storage_controller.dart';

import 'controllers/weather_controller.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  await GetStorage.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => WeatherController());
          Get.lazyPut(() => StorageController());
        },
      ),
      home: const HomeScreen(),
    );
  }
}
