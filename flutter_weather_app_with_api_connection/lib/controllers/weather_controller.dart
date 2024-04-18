import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/api_service.dart';
import '../models/location.dart';
import '../models/weather.dart';
import '../utils/constants.dart';
import 'storage_controller.dart';

class WeatherController extends GetxController {
  final storageController = Get.find<StorageController>();

  // used to load the api key from .env file
  final String _apiKey = dotenv.env['API_KEY']!;

  final Rx<Location?> location = Rx(null);

  String? errorMessage;

  TextEditingController cityName = TextEditingController();

// used for comparing dates
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<dynamic> getWeather({num? lat, num? lon}) async {
    List<Weather> weatherList = [];

    if (await isInternetConnected) {
      var url =
          '${weatherForecastBaseApi}lat=${lat ?? location.value!.lat}&lon=${lon ?? location.value!.lon}&appid=$_apiKey';
      var response = await ApiService.getMethod(url);

      if (response.statusCode == 200) {
        // parse json response to Weather model instance
        for (final weather in jsonDecode(response.body)["list"]) {
          weatherList.add(Weather.fromJson(weather));
        }

        return weatherList;
      }
    } else {
      errorMessage = "internet";
    }
  }

  Future<dynamic> getLocations({required String cityName}) async {
    List<Location> locationList = [];

    if (await isInternetConnected) {
      var url = '${geocodingBaseApi}q=$cityName&appid=$_apiKey';

      var response = await ApiService.getMethod(url);

      if (response.statusCode == 200) {
        if ((jsonDecode(response.body) as List).isEmpty) {
          errorMessage = 'Nothing Found';
        } else {
          for (final location in jsonDecode(response.body)) {
            locationList.add(Location.fromJson(location));
          }

          return locationList;
        }
      }
    } else {
      errorMessage = "internet";
    }
  }

  List<Weather> getTodayHourlyWeatherList(List<Weather> weatherList) {
    List<Weather> todayWeatherList = [];

    for (final Weather weather in weatherList) {
      if (weather.date.compareTo(today) == 0) {
        todayWeatherList.add(weather);
      }
    }

    return todayWeatherList;
  }

  List<Weather> getDailyWeatherList(List<Weather> weatherList) {
    // used to remove duplicated weather dates
    // weather list contains daily and hourly weather information
    // the hourly weather information needs to be removed
    Set<Weather> seen = {};

    // used to remove duplicated weather dates
    List<Weather> dailyWeatherList =
        weatherList.where((element) => seen.add(element)).toList();

    // removes today weather element
    // today weather is shown on the home screen
    // it shouldn't be shown in the other days weather screen
    dailyWeatherList
        .removeWhere((element) => element.date.compareTo(today) == 0);

    return dailyWeatherList;
  }

  // checks internet connection state
  Future<bool> get isInternetConnected async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    // load the saved location when app run
    location.value = storageController.loadLocation();

    super.onInit();
  }
}
