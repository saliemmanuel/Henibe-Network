import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_provider.dart';
import '../../../../widget/custom_text.dart';
import '../../../widget/column_chart.dart';

class LTERapport extends StatefulWidget {
  const LTERapport({super.key});

  @override
  State<LTERapport> createState() => _LTERapportState();
}

class _LTERapportState extends State<LTERapport> {
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
            child: gsmRapport(_rapportListHistorique),
          ),
        ));
  }

  gsmRapport(List<dynamic>? data) {
    for (var item in data!) {
      if (item["networktype"] == "lte".toUpperCase()) {
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
          typeReseau: "Type signal : LTE",
          map: map,
          sum: sum,
          maximum: maximum.toDouble(),
          label: 'RSRP',
        ),
        ColumnChart(
          typeReseau: "Type signal : LTE",
          map: map,
          sum: sum,
          maximum: maximum.toDouble(),
          label: 'RSRQ',
        )
      ],
    );
  }
}