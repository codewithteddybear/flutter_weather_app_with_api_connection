import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'other_days_weather_screen.dart';
import '../controllers/weather_controller.dart';
import '../utils/constants.dart';
import '../models/weather.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return Scaffold(
      // used to prevent widgets from changing when dialog and keyboard is open
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const SearchLocationDialog(),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on),
            Obx(
              () => Text(
                weatherController.location.value!.name,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),

      extendBodyBehindAppBar: true,

      body: Obx(
        () => FutureBuilder(
          future: weatherController.getWeather(
            lat: weatherController.location.value!.lat,
            lon: weatherController.location.value!.lon,
          ),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingW();
              //
            } else if (snapshot.hasError || snapshot.data == null) {
              // if errorMessage variable contains internet it means there's no internet connection
              if (weatherController.errorMessage == 'internet') {
                return const ErrorW(isInternetConnectionError: true);
              }
              //
              return const ErrorW();
              //
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WeatherCard(weather: snapshot.data[0]),
                  _BuildFooter(
                    hourlyWeatherList: weatherController
                        .getTodayHourlyWeatherList(snapshot.data),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _BuildFooter extends StatelessWidget {
  const _BuildFooter({
    required this.hourlyWeatherList,
  });

  final List<Weather> hourlyWeatherList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(
                  onPressed: () => Get.to(
                    () => const OtherDaysWeatherScreen(),
                    transition: Transition.leftToRight,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[500],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Other  Days",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey[500]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
            _BuildHourlyWeather(weatherList: hourlyWeatherList)
          ],
        ),
      ),
    );
  }
}

class _BuildHourlyWeather extends StatelessWidget {
  const _BuildHourlyWeather({
    required this.weatherList,
  });

  final List<Weather> weatherList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: weatherList.length,
        itemBuilder: (context, index) {
          final weather = weatherList[index];
          return HourlyWeatherCard(
            icon: getWeatherStateIcon(weather.state)["icon"],
            iconColor: getWeatherStateIcon(weather.state)["color"],
            temp: weather.temp,
            time: weather.time,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
