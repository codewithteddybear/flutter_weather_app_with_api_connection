import 'package:flutter/material.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
