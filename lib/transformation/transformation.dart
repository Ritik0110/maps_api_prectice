import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Transformation extends StatefulWidget {
  const Transformation({super.key});

  @override
  State<Transformation> createState() => _TransformationState();
}

class _TransformationState extends State<Transformation> {
  String placeAddress = "";
  String cordinates = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [Colors.white, Colors.yellowAccent.shade100])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\n Cordinates : $cordinates,\n Address : $placeAddress",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () async {
                List<Placemark> marks = await placemarkFromCoordinates(
                    23.021486156391326, 72.5544560580049);
                List<Location> locations = await locationFromAddress(
                    "Saffron Tower, Ambawadi, Ahmedabad, Gujarat, India");
                setState(() {
                  // this is how we can fetch the cordinates from the address
                  cordinates =
                      "latitude -${locations.first.latitude},longitude -${locations.first.longitude}";

                  // this is how we f=can fetch the address from the lat and long
                  placeAddress =
                      "name -${marks.first.name},locality -${marks.first.locality},"
                          "addministrative -${marks.first.administrativeArea},"
                      "street -${marks.first.street},sub-addministrative -${marks.first.subAdministrativeArea},sub locality -${marks.first.subLocality},"
                          "code -${marks.first.postalCode},iso -${marks.first.isoCountryCode}";
                });
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(child: Text("Hit to convert")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
