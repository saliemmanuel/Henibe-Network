import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RSRPMapScreen extends StatefulWidget {
  final List<dynamic>? dataForMap;
  const RSRPMapScreen({Key? key, required this.dataForMap}) : super(key: key);

  @override
  State<RSRPMapScreen> createState() => _RSRPMapScreenState();
}

class _RSRPMapScreenState extends State<RSRPMapScreen> {
  late Completer<GoogleMapController> _controller;
  late CameraPosition? _initPosition;
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(10.6347172, 14.3949691), zoom: 12.20);

  @override
  void initState() {
    _controller = Completer();
    _initPosition = const CameraPosition(
        target: LatLng(10.6347172, 14.3949691), zoom: 12.20);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    const CameraPosition _initPosition =
        CameraPosition(target: LatLng(10.6347172, 14.3949691), zoom: 12.20);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 1; i < widget.dataForMap!.length; i++)
            Column(
              children: [
                Text(widget.dataForMap![i]['latitude'] ?? 10.6347172),
                Text("dsd"),
                Text(widget.dataForMap![i]['longitude'] ?? 14.3949691),
              ],
            )
        ],
      ),
    );

    // return Stack(
    //   children: [
    //     GoogleMap(
    //       zoomControlsEnabled: false,
    //       markers: {
    //         for (var i = 1; i < widget.dataForMap!.length; i++)
    //           Marker(
    //             markerId: MarkerId("marquer_$i"),
    //             position: LatLng(
    //                 double.parse(widget.dataForMap![i]["latitude"]),
    //                 double.parse(widget.dataForMap![i]['longitude'])),
    //             // icon: colorPin(widget.dataForMap![i]),
    //           ),
    //       },
    //       initialCameraPosition: _initPosition,
    //       onMapCreated: (GoogleMapController controller) {
    //         _controller.complete(controller);
    //       },
    //     ),
    //     Positioned(
    //       top: 8.0,
    //       right: 10,
    //       child: Container(
    //         color: Colors.black,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Text(
    //                 "Qualité du signal (RSRP)",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(3.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       color: Colors.lightGreen,
    //                     ),
    //                     const Text(
    //                       " Excellent (>= -80)",
    //                       style: TextStyle(color: Colors.white),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(3.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       color: Colors.yellowAccent,
    //                     ),
    //                     const Text(
    //                       " Good (-80 à -90)",
    //                       style: TextStyle(color: Colors.white),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(3.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       color: Colors.pink,
    //                     ),
    //                     const Text(
    //                       " Mid Cell (-90 à -100)",
    //                       style: TextStyle(color: Colors.white),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(3.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       color: Colors.red,
    //                     ),
    //                     const Text(
    //                       " Call Edge (>=-100)",
    //                       style: TextStyle(color: Colors.white),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  // colorPin(var data) {
  //   if (data[0][0].toString().split(';')[k] == "RSRP") {
  //     if (int.parse(data[i][0].toString().split(';')[k]) >= -80) {
  //       return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  //     }
  //     if (int.parse(data[i][0].toString().split(';')[k]) < -80 &&
  //         int.parse(data[i][0].toString().split(';')[k]) > -90) {
  //       return BitmapDescriptor.defaultMarkerWithHue(
  //           BitmapDescriptor.hueYellow);
  //     }
  //     if (int.parse(data[i][0].toString().split(';')[k]) < -90 &&
  //         int.parse(data[i][0].toString().split(';')[k]) > -100) {
  //       return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
  //     }
  //     if (int.parse(data[i][0].toString().split(';')[k]) < -90 &&
  //         int.parse(data[i][0].toString().split(';')[k]) > -100) {
  //       return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  //     }
  //   }
  // }
}
