import 'dart:async';

import 'package:bheya_network_example/view/home_item/map/widget/rsrp_widget_map.dart';
import 'package:bheya_network_example/view/home_item/map/widget/rsrq_widget_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  final dataForMap;
  const MapsScreen({Key? key, required this.dataForMap}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    var page = [
      RSRPMapScreen(dataForMap: widget.dataForMap),
      RSRQMapScreen(dataForMap: widget.dataForMap),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Map Ether"),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        index = 0;
                        setState(() {});
                      }),
                  IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        index = 1;
                        setState(() {});
                      }),
                ],
              ),
            ],
          ),
        ),
        body: ListView(
          children: [Text(widget.dataForMap.toString())],
        ));
  }
}
// page[index]