import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    const Marker(
        markerId: MarkerId("First"),
        position: LatLng(23.023486156391326, 72.5544560580049),
        infoWindow: InfoWindow(title: "My Home")),
    // const Marker(
    //     markerId: MarkerId("Second"),
    //     position: LatLng(23.021486156391350, 72.5554560590075),
    //     infoWindow: InfoWindow(title: "second Marker")),
  ];

  final CameraPosition _initialCameraPosition = const CameraPosition(
      target: LatLng(23.023486156391326, 72.5544560580049), zoom: 20);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
  }

  Future<Position> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) {
        print("Error :- $error");
      });
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  packData() {
    getCurrentLocation().then((value) async {
      print("value :- $value");
      myMarker.add(Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "Current Location")));
      CameraPosition currentCameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 20);
      final GoogleMapController mapController =await _controller.future;
      mapController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
      setState(() {

      });
      // setState(() {
      //   myMarker.add(Marker(
      //       markerId: MarkerId("Second"),
      //       position: LatLng(value.latitude, value.longitude),
      //       infoWindow: InfoWindow(title: "My Current Location")));
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(myMarker),
          mapType: MapType.normal,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // method to call user current location
          packData();
        },
        child: const Icon(
          Icons.my_location,
          size: 18,
        ),
      ),
    );
  }
}
