import 'package:flutter/material.dart';
import 'package:flutter_weather_app_with_api_connection/widgets/widgets.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';
import '../models/weather.dart';

class OtherDaysWeatherScreen extends StatefulWidget {
  const OtherDaysWeatherScreen({super.key});

  @override
  State<OtherDaysWeatherScreen> createState() => _OtherDaysWeatherScreenState();
}

class _OtherDaysWeatherScreenState extends State<OtherDaysWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return Scaffold(
      appBar: AppBar(
        leading: const _BuildBackButton(),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today_outlined),
            Text(
              "Other days",
              style: Theme.of(context).textTheme.labelMedium,
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
      body: FutureBuilder(
        future: weatherController.getWeather(),
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
            List<Weather> dailyWeatherList =
                weatherController.getDailyWeatherList(snapshot.data);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WeatherCard(
                  weather: dailyWeatherList[0],
                  isLarge: false,
                ),
                _BuildDailyWeather(dailyWeatherList: dailyWeatherList),
              ],
            );
          }
        },
      ),
    );
  }
}

class _BuildDailyWeather extends StatelessWidget {
  const _BuildDailyWeather({required this.dailyWeatherList});

  final List<Weather> dailyWeatherList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        // used to removes tomorrow index
        // it's shown above in the WeatherCard
        itemCount: dailyWeatherList.length - 1,
        itemBuilder: (context, index) => DailyWeatherCard(
          // used to removes tomorrow index
          weather: dailyWeatherList[index + 1],
        ),
      ),
    );
  }
}

class _BuildBackButton extends StatelessWidget {
  const _BuildBackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => Get.back(),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
