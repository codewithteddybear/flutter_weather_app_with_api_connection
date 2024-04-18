import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather.dart';
import '../utils/constants.dart';
import 'weather_details_card.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.weather,
    this.isLarge = true,
  });

  final Weather weather;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isLarge ? 4 : 3,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              spreadRadius: 8,
              blurRadius: 8,
            )
          ],
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLarge
                // large style
                ? Column(
                    children: [
                      Icon(
                        getWeatherStateIcon(weather.state)["icon"],
                        color: getWeatherStateIcon(weather.state)["color"],
                        size: 100,
                      ),
                      Text(
                        "${weather.temp}°",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        weather.state,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        DateFormat("EEEE, d MMMM").format(weather.date),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white70),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10,
                        ),
                        child: Divider(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                // small style
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getWeatherStateIcon(weather.state)["icon"],
                        color: getWeatherStateIcon(weather.state)["color"],
                        size: 100,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tomorrow",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "${weather.maxTemp}",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: "/${weather.minTemp}°",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            weather.state,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white70),
                          ),
                        ],
                      )
                    ],
                  ),
            const SizedBox(height: 10),
            _BuildWeatherDetails(weather: weather)
          ],
        ),
      ),
    );
  }
}

class _BuildWeatherDetails extends StatelessWidget {
  const _BuildWeatherDetails({
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WeatherDetailsCard(
          icon: CupertinoIcons.wind,
          title: "${weather.wind} m/s",
          description: "Wind",
        ),
        WeatherDetailsCard(
          icon: CupertinoIcons.drop_fill,
          title: "${weather.humidity}%",
          description: "Humidity",
        ),
        WeatherDetailsCard(
          icon: Icons.beach_access,
          title: "${weather.pressure} hPa",
          description: "Pressure",
        ),
      ],
    );
  }
}
