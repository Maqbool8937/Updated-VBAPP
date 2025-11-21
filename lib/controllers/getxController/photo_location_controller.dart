import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vagrancy_beggars/view/screens/final_step_screen.dart';

class PhotoLocationController extends GetxController {
  final picker = ImagePicker();
  var images = <File>[].obs;
  var selectedLocation = const LatLng(37.7749, -122.4194).obs; // Default: SF
  var address = "123 Main Street, San Francisco, CA 94105".obs;

  /// Pick photo from gallery
  Future<void> pickImage() async {
    if (images.length >= 3) return;
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.add(File(picked.path));
    }
  }

  /// Remove photo
  void removeImage(int index) {
    images.removeAt(index);
  }

  /// Update map pin position and reverse geocode
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
            "${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}";
      }
    } catch (e) {
      address.value = "Unknown Location";
    }
  }

  void onContinue() {
    print("Photos selected: ${images.length}");
    print("Location: ${selectedLocation.value}");
    print("Address: ${address.value}");
    Get.to(() => FinalStepScreen());
  }
}
