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

    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          markers: {
            for (var i = 1; i < widget.dataForMap!.length; i++)
              Marker(
                markerId: MarkerId("marquer_$i"),
                position: LatLng(
                    double.parse(
                        widget.dataForMap![i]['latitude'].toString() == ""
                            ? "10.6347172"
                            : widget.dataForMap![i]['latitude'].toString()),
                    double.parse(
                        widget.dataForMap![i]['longitude'].toString() == ""
                            ? "14.3949691"
                            : widget.dataForMap![i]['longitude'].toString())),
                icon: colorPin(widget.dataForMap![i]['dBm']),
              ),
          },
          initialCameraPosition: _initPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ],
    );
  }

  colorPin(var data) {
    if (int.parse(data.toString().replaceAll("-", '')) >= int.parse('-80')) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    }
    if (int.parse(data.toString().replaceAll("-", '')) >
            int.parse('-80'.replaceAll("-", '')) &&
        int.parse(data.replaceAll("-", '')) <
            int.parse('-90'.replaceAll("-", ''))) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    }
    if (int.parse(data.toString().replaceAll("-", '')) >
            int.parse("-90".replaceAll("-", '')) &&
        int.parse(data.toString().replaceAll("-", '')) <
            int.parse("-100".replaceAll("-", ''))) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    }
    if (int.parse(data.toString().replaceAll("-", '')) >
            int.parse("-90".replaceAll("-", '')) &&
        int.parse(data.toString().replaceAll("-", '')) <
            int.parse('-100'.replaceAll("-", ''))) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }
}
