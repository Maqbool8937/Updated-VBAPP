import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends GetxController {
  var currentPosition = Rxn<LatLng>();
  var isLoading = false.obs;
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  /// Get current location
  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Error', 'Location services are disabled.');
        return;
      }

      // Check location permissions
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

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);

      // Move camera after a short delay to ensure mapController is ready
      await Future.delayed(const Duration(milliseconds: 300));
      moveToCurrentLocation();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// When map is created
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    moveToCurrentLocation();
  }

  /// Move camera to current location
  Future<void> moveToCurrentLocation() async {
    if (mapController == null || currentPosition.value == null) return;

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition.value!, zoom: 16),
      ),
    );
  }
}




// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class MapController extends GetxController {
//   var currentPosition = Rxn<LatLng>();
//   var isLoading = false.obs;
//   GoogleMapController? mapController;

//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }

//   Future<void> getCurrentLocation() async {
//     try {
//       isLoading.value = true;

//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         Get.snackbar('Error', 'Location services are disabled.');
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           Get.snackbar('Error', 'Location permissions are denied.');
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         Get.snackbar('Error', 'Location permissions are permanently denied.');
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       currentPosition.value = LatLng(position.latitude, position.longitude);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get location: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Future<void> moveToCurrentLocation() async {
//     if (mapController == null || currentPosition.value == null) return;
//     mapController!.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(target: currentPosition.value!, zoom: 16),
//       ),
//     );
//   }
// }


