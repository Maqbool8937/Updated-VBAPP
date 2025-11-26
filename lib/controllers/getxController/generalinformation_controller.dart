import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class GeneralInformationController extends GetxController {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  var isLoadingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    setCurrentDateTime(); // Auto-show current date & time
  }

  // Auto Set Current Date & Time
  void setCurrentDateTime() {
    final now = DateTime.now();
    dateController.text = DateFormat('yyyy-MM-dd hh:mm a').format(now);
  }

  // Pick Date & Time Manually
  Future<void> pickDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return;

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return;

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    dateController.text = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
  }

  // Get Current Location
  Future<void> getCurrentLocation() async {
    try {
      isLoadingLocation.value = true;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Error', 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Error', 'Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        locationController.text =
            '${place.locality}, ${place.subAdministrativeArea}, ${place.country}';
      } else {
        locationController.text = 'Location unavailable';
      }
    } catch (e) {
      locationController.text = 'Error getting location';
      Get.snackbar('Error', e.toString());
    } finally {
      isLoadingLocation.value = false;
    }
  }
}
