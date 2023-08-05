import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bheya_network_example/provider/app_provider.dart';
import 'package:bheya_network_example/widget/custom_text.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: const CustomText(
          "Localisation de mon analyse",
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        )),
        body: Scrollbar(
          child: Consumer<AppProvider>(
            builder: (context, value, child) {
              var initialCameraPosition = CameraPosition(
                  target: LatLng(
                      value.lat == null
                          ? 10.6347172
                          : double.parse(value.lat.toString()),
                      value.long == null
                          ? 14.3949691
                          : double.parse(value.long.toString())),
                  zoom: 13.20);
              return ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 230.0,
                    width: size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23.0),
                      child: Stack(
                        children: [
                          GoogleMap(
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            markers: {
                              Marker(
                                markerId: const MarkerId("1"),
                                position: LatLng(
                                    value.lat == null
                                        ? 10.6347172
                                        : double.parse(value.lat.toString()),
                                    value.long == null
                                        ? 14.3949691
                                        : double.parse(value.long.toString())),
                              ),
                            },
                            initialCameraPosition: initialCameraPosition,
                            mapType: MapType.terrain,
                            onMapCreated: (controller) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("DateAndTime : ${value.date}"),
                        const Divider(),
                        CustomText(value.servicestatus
                            ? "Longitude : ${value.long}"
                            : "GPS is disabled."),
                        const Divider(),
                        CustomText(value.servicestatus
                            ? "Latitude : ${value.lat}"
                            : "GPS is disabled."),
                        const Divider(),
                        CustomText(value.servicestatus
                            ? "Altitude : ${value.altitude}"
                            : "GPS is disabled."),
                        const Divider(),
                        CustomText(value.servicestatus
                            ? "speedMps : ${value.speedMps}"
                            : "GPS is disabled."),
                        const Divider(),
                        CustomText(value.servicestatus
                            ? "speed Accuracy : ${value.speedAccuracy}"
                            : "GPS is disabled."),
                        const Divider(),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
