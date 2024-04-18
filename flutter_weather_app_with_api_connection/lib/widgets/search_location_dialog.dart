import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/storage_controller.dart';
import '../controllers/weather_controller.dart';
import '../models/location.dart';
import 'widgets.dart';

class SearchLocationDialog extends StatefulWidget {
  const SearchLocationDialog({super.key});

  @override
  State<SearchLocationDialog> createState() => _SearchLocationDialogState();
}

class _SearchLocationDialogState extends State<SearchLocationDialog> {
  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BuildTextField(
              controller: weatherController.cityName,
              onChange: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            weatherController.cityName.text.isNotEmpty
                ? FutureBuilder(
                    future: weatherController.getLocations(
                        cityName: weatherController.cityName.text),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingW();
                      } else if (snapshot.hasError || snapshot.data == null) {
                        if (weatherController.errorMessage == 'internet') {
                          return const ErrorW(isInternetConnectionError: true);
                        }
                        return ErrorW(
                          text: weatherController.errorMessage!,
                        );
                      } else {
                        List<Location> locationList = snapshot.data;

                        return Expanded(
                          child: ListView.separated(
                            itemCount: locationList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              Location location = locationList[index];

                              return _CityItem(location: location);
                            },
                          ),
                        );
                      }
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _CityItem extends StatelessWidget {
  const _CityItem({
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final storageController = Get.find<StorageController>();
    final weatherController = Get.find<WeatherController>();

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey),
      ),
      title: Text(location.name),
      subtitle: Text(location.country),
      onTap: () {
        storageController.saveLocation(location);
        weatherController.location.value = location;

        weatherController.cityName.clear();

        Navigator.of(context).pop();
      },
    );
  }
}

class _BuildTextField extends StatelessWidget {
  const _BuildTextField({
    required this.controller,
    required this.onChange,
  });

  final TextEditingController controller;
  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.grey),
    );
    return TextField(
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_on),
        enabledBorder: border,
        focusedBorder: border,
        hintStyle: const TextStyle(color: Colors.white70, fontSize: 18),
        hintText: "Enter your city name",
        filled: true,
        fillColor: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
