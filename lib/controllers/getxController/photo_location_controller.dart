import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PhotoLocationController extends GetxController {
  final picker = ImagePicker();

  /// Observables
  var images = <File>[].obs;
  var selectedLocation = const LatLng(37.7749, -122.4194).obs;
  var address = "123 Main Street, San Francisco, CA".obs;

  /// Pick Image
  Future<void> pickImage() async {
    if (images.length >= 3) return;
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.add(File(picked.path));
    }
  }

  /// Remove Image
  void removeImage(int index) {
    images.removeAt(index);
  }

  /// Update Location + Reverse Geocode
  Future<void> updateLocation(LatLng newPosition) async {
    selectedLocation.value = newPosition;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        newPosition.latitude,
        newPosition.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address.value =
            "${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''} ${place.postalCode ?? ''}"
                .trim();
      } else {
        address.value = "Unknown Location";
      }
    } catch (e) {
      address.value = "Unknown Location";
    }
  }

  /// Get Live GPS Location
  Future<void> getLiveLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Check if GPS enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Disabled", "Please turn on GPS.");
      await Geolocator.openLocationSettings();
      return;
    }

    /// Check Permission
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
        "Permission Permanently Denied",
        "Enable location permission from your app settings.",
      );
      return;
    }

    /// Get Current Location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng liveLatLng = LatLng(position.latitude, position.longitude);

    /// Update location + reverse geocode
    await updateLocation(liveLatLng);
  }

  /// Final Step Action
  void onContinue() {
    print("Photos: ${images.length}");
    print("Location: ${selectedLocation.value}");
    print("Address: ${address.value}");
  }
}
