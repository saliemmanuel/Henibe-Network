import 'package:bheya_network_example/view/widget/column_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widget/custom_text.dart';

class RapportScreen extends StatefulWidget {
  const RapportScreen({super.key});

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  Map map = {};
  List<dynamic>? _rapportListHistorique;
  int sum = 0;
  @override
  void initState() {
    initRapportList();
    super.initState();
  }

  initRapportList() async {
    _rapportListHistorique =
        Provider.of<AppProvider>(context, listen: false).listHistorique;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText("Rapport",
              fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        body: sendSpecifiqueInfo(_rapportListHistorique));
  }

  sendSpecifiqueInfo(List<dynamic>? data) {
    for (var item in data!) {
      if (item["networktype"] == "wcdma".toUpperCase()) {
        if (!map.containsKey(item["dBm"])) {
          map[item["dBm"]] = 1;
        } else {
          map[item["dBm"]] += 1;
        }
      }
    }
    Iterable<dynamic> values = map.values;
    int sum = values.reduce((sum, value) => sum + value);
    int maximum = values.first;
    for (var element in values) {
      if (maximum < element) maximum = element;
    }
    return Column(
      children: [
        ColumnChart(map: map, sum: sum, maximum: maximum.toDouble()),
      ],
    );
    setState(() {});
  }
}
