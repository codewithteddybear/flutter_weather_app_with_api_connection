import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../models/location.dart';

class StorageController extends GetxController {
  final String _key = "location";
  final _box = GetStorage();

  Location loadLocation() {
    return Location.fromJson(jsonDecode(_box.read(_key)));
  }

  void saveLocation(Location location) async {
    await _box.write(_key, location.toJson());
  }

  @override
  void onInit() async {
    // when apps launch for the first time the default location sets as London
    await _box.writeIfNull(
      _key,
      Location(
        name: "London",
        country: "England",
        lat: 51.5073219,
        lon: -0.1276474,
      ).toJson(),
    );

    super.onInit();
  }
}
