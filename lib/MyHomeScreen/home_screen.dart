import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
    const Marker(
        markerId: MarkerId("First"),
        position: LatLng(23.021486156391326, 72.5544560580049),
        infoWindow: InfoWindow(title: "First Marker")),
    const Marker(
        markerId: MarkerId("Second"),
        position: LatLng(23.021486156391350, 72.5554560590075),
        infoWindow: InfoWindow(title: "second Marker")),
  ];

  final CameraPosition _initialCameraPosition = const CameraPosition(
      target: LatLng(23.021486156391326, 72.5544560580049), zoom: 20);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
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
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(23.021486156391350, 72.5554560590075),
                    zoom: 20)));
          },
          child: const Icon(
            Icons.my_location,
            size: 18,
          )),
    );
  }
}
