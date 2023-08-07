import 'package:bheya_network_example/view/home_item/map/widget/rsrp_widget_map.dart';
import 'package:bheya_network_example/view/home_item/map/widget/rsrq_widget_map.dart';
import 'package:flutter/material.dart';

import '../../../widget/custom_text.dart';

class MapsScreen extends StatefulWidget {
  final List<dynamic>? listHistorique;
  const MapsScreen({
    Key? key,
    required this.listHistorique,
  }) : super(key: key);

  @override
  MapsScreenState createState() => MapsScreenState();
}

class MapsScreenState extends State<MapsScreen> {
  var index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText("Carte",
              fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        body: RSRPMapScreen(dataForMap: widget.listHistorique));
  }
}
