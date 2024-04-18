import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import '../models/weather.dart';

class DailyWeatherCard extends StatelessWidget {
  const DailyWeatherCard({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.E().format(weather.date),
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.grey),
          ),
          Row(
            children: [
              Icon(
                getWeatherStateIcon(weather.state)["icon"],
                color: getWeatherStateIcon(weather.state)["color"],
                size: 40,
              ),
              const SizedBox(width: 5),
              Text(
                weather.state,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          Text.rich(
            TextSpan(
              text: "${weather.maxTemp}",
              style: Theme.of(context).textTheme.labelMedium,
              children: [
                TextSpan(
                  text: "/${weather.minTemp}°",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
