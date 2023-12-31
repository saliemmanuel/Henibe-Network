import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RSRQMapScreen extends StatefulWidget {
  final dataForMap;
  const RSRQMapScreen({Key? key, required this.dataForMap}) : super(key: key);

  @override
  State<RSRQMapScreen> createState() => _RSRQMapScreenState();
}

class _RSRQMapScreenState extends State<RSRQMapScreen> {
  late Completer<GoogleMapController> _controller;
  late CameraPosition? _initPosition;
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(10.6347172, 14.3949691), zoom: 12.20);

  @override
  void initState() {
    _controller = Completer();
    _initPosition =
        const CameraPosition(target: LatLng(10.6347172, 14.3949691), zoom: 15);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    const CameraPosition _initPosition =
        CameraPosition(target: LatLng(10.6347172, 14.3949691), zoom: 12.20);
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          markers: {
            for (var i = 1; i < widget.dataForMap!.length; i++)
              Marker(
                markerId: MarkerId("fin${i + 2}"),
                position: LatLng(
                    double.parse(
                        widget.dataForMap[i][0].toString().split(';')[10]),
                    double.parse(
                        widget.dataForMap[i][0].toString().split(';')[11])),
                icon: colorPin(widget.dataForMap, 42, i),
              ),
          },
          initialCameraPosition: _initPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Positioned(
          top: 8.0,
          right: 10,
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Puissance du Signal (RSSI)",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: Colors.lightGreen,
                        ),
                        const Text(
                          " Excellent (>= -10)",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: Colors.yellowAccent,
                        ),
                        const Text(
                          " Good (-10 à -15)",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: Colors.pink,
                        ),
                        const Text(
                          " Mid Cell (-15 à -20)",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: Colors.red,
                        ),
                        const Text(
                          " Call Edge (< -20)",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  colorPin(var data, var k, var i) {
    if (data[0][0].toString().split(';')[k] == "RSRQ") {
      if (int.parse(data[i][0].toString().split(';')[k]) >= -10) {
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      }
      if (int.parse(data[i][0].toString().split(';')[k]) < -10 &&
          int.parse(data[i][0].toString().split(';')[k]) > -15) {
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow);
      }
      if (int.parse(data[i][0].toString().split(';')[k]) <= -15 &&
          int.parse(data[i][0].toString().split(';')[k]) >= -20) {
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
      }
      if (int.parse(data[i][0].toString().split(';')[k]) <= -20) {
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      }
    }
  }
}
