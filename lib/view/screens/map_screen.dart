import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vagrancy_beggars/controllers/getxController/mapcontroller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Location'),
        backgroundColor: Colors.redAccent,
      ),
      // body: Obx(() {
      //   if (mapController.isLoading.value) {
      //     return const Center(child: CircularProgressIndicator());
      //   }

      //   if (mapController.currentPosition.value == null) {
      //     return const Center(child: Text("Unable to get location"));
      //   }

      //   return GoogleMap(
      //     initialCameraPosition: CameraPosition(
      //       target: mapController.currentPosition.value!,
      //       zoom: 16,
      //     ),
      //     myLocationEnabled: true,
      //     myLocationButtonEnabled: true,
      //     onMapCreated: mapController.onMapCreated,
      //     zoomControlsEnabled: true,
      //   );
      // }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: mapController.moveToCurrentLocation,
      //   child: const Icon(Icons.my_location),
      // ),
      body: Center(child: Text('Please Enable Google map Api')),
    );
  }
}
