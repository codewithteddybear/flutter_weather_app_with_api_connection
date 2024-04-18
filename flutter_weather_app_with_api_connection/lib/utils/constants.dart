import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String geocodingBaseApi =
    "https://api.openweathermap.org/geo/1.0/direct?limit=5&";
const String weatherForecastBaseApi =
    "https://api.openweathermap.org/data/2.5/forecast?units=metric&";

/// return a map containing a icon and a color base on the given state
Map<String, dynamic> getWeatherStateIcon(String state) {
  if (state == "Clouds") {
    return {"icon": Icons.cloud, "color": Colors.white};
  } else if (state == "Clear") {
    return {"icon": Icons.sunny, "color": Colors.yellow};
  } else if (state == "Rain") {
    return {"icon": CupertinoIcons.cloud_rain_fill, "color": Colors.blue[900]};
  } else if (state == "Snow") {
    return {"icon": CupertinoIcons.snow, "color": Colors.white};
  }

  // if there's a new state it return a cloudy sate by default
  return {"icon": Icons.cloud, "color": Colors.white};
}
