import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> getLiveLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar("Permission Denied", "Location permission is required.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Get.snackbar(
      "Permission Denied",
      "Enable location permission in settings.",
    );
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  LatLng liveLatLng = LatLng(position.latitude, position.longitude);

  // await Get.find<LocationController>().updateLocation(liveLatLng);
}

class LocationController extends GetxController {
  Rx<LatLng?> liveLocation = Rx<LatLng?>(null);

  void updateLocation(LatLng newLoc) {
    liveLocation.value = newLoc;
  }
}
