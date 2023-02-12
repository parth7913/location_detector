import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../HomeScreen/Controller/HomeController.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.CheckPermission();
    Get.put(HomeController()).GetCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Your Current Location",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Obx(
          () => GoogleMap(
            onMapCreated: (controller) {
              homeController.completer.value.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: homeController.CurrentLocation.value,
              zoom: 11.0,
              tilt: 0,
              bearing: 0,
            ),
            markers: homeController.Markers(),
            // myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ),
      ),
    );
  }
}
