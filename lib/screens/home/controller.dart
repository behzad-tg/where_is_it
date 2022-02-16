import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wheretoeat/data.dart';

class HomeTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class HomeMapController extends GetxController {
  Location location = Location();
  late GoogleMapController controller;
  late LocationData locationData;
  RxSet<Marker> markers = <Marker>{}.obs;
  // RxSet<Circle> circles = <Circle>{}.obs;
  RxBool isloading = false.obs;
  RxString dropDownSelected = ''.obs;
  RxBool dropDownBtn = false.obs;

  initPlatformState() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
  }

  getMarks() async {
    isloading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    for (final obj in places) {
      markers.add(
        Marker(
          markerId:
              MarkerId('marker_id_${DateTime.now().millisecondsSinceEpoch}'),
          position: LatLng(
            double.parse(obj.latitude.toString()),
            double.parse(obj.longitude.toString()),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    }
    isloading.value = false;
  }

  // getCircle() async {
  //   locationData = await location.getLocation();
  //   circles.add(
  //     Circle(
  //       circleId:
  //           CircleId('circle_id_${DateTime.now().millisecondsSinceEpoch}'),
  //       center: LatLng(
  //         locationData.latitude as double,
  //         locationData.longitude as double,
  //       ),
  //       radius: 200,
  //       fillColor: Colors.blue.withOpacity(0.2),
  //       visible: false,
  //       strokeWidth: 0,
  //     ),
  //   );
  // }

  @override
  void onInit() {
    dropDownSelected.value = 'رستوران';
    initPlatformState();
    getMarks();
    // getCircle();
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FavoritController extends GetxController {
  RxList<Place> favPlace = <Place>[].obs;
}
