import 'package:flutter/material.dart';

class GooglePlaceApi extends StatefulWidget {
  const GooglePlaceApi({super.key});

  @override
  State<GooglePlaceApi> createState() => _GooglePlaceApiState();
}

class _GooglePlaceApiState extends State<GooglePlaceApi> {
  final TextEditingController searchController = TextEditingController();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Place Api for Google Map Search "),
        ),
        body: Padding(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search place here",
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: const Icon(Icons.clear)),
              ),
            ),
          ],
        )),

      ),
    );
  }
}
