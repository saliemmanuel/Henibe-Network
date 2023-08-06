import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_provider.dart';
import '../../../../widget/custom_text.dart';
import '../../../widget/column_chart.dart';

class WDMARapport extends StatefulWidget {
  const WDMARapport({super.key});

  @override
  State<WDMARapport> createState() => _WDMARapportState();
}

class _WDMARapportState extends State<WDMARapport> {
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
        body: Scrollbar(
          child: SingleChildScrollView(
            child: wDMARapport(_rapportListHistorique),
          ),
        ));
  }

  wDMARapport(List<dynamic>? data) {
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
        ColumnChart(
          typeReseau: "Diagramme DBM du Signal WCDMA",
          map: map,
          sum: sum,
          maximum: maximum.toDouble(),
          label: "DBm",
        ),
        const SizedBox(height: 40.0)
      ],
    );
  }
}
