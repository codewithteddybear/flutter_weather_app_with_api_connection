import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({
    super.key,
    required this.icon,
    required this.temp,
    required this.time,
    required this.iconColor,
  });

  final IconData icon;
  final Color iconColor;
  final num temp;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$temp°",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Icon(
            icon,
            color: iconColor,
          ),
          Text(
            DateFormat.Hm().format(time),
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
