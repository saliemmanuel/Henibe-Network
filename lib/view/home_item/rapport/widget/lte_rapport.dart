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
  Map mapRSRP = {};
  Map mapRSRQ = {};
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
      if (item["networktype"] == "gsm".toUpperCase()) {
        if (!mapRSRP.containsKey(item["rSRP"])) {
          mapRSRP[item["rSRP"]] = 1;
        } else {
          mapRSRP[item["rSRP"]] += 1;
        }
        if (!mapRSRQ.containsKey(item["rSRQ"])) {
          mapRSRQ[item["rSRQ"]] = 1;
        } else {
          mapRSRQ[item["rSRQ"]] += 1;
        }
      }
    }

    Iterable<dynamic> values = mapRSRP.values;
    int sumRSRP = values.reduce((sum, value) => sum + value);
    int maximumRSRP = values.first;
    for (var element in values) {
      if (maximumRSRP < element) maximumRSRP = element;
    }

    Iterable<dynamic> valuesRSRP = mapRSRQ.values;
    int sumRSRQ = valuesRSRP.reduce((sum, value) => sum + value);
    int maximumRSRQ = valuesRSRP.first;
    for (var element in values) {
      if (maximumRSRQ < element) maximumRSRQ = element;
    }
    return Column(
      children: [
        ColumnChart(
          typeReseau: "Diagramme RSRP du  Signale LTE",
          map: mapRSRP,
          sum: sumRSRP,
          maximum: maximumRSRP.toDouble(),
          label: 'RSRP',
        ),
        ColumnChart(
          typeReseau: "Diagramme RSRQ Signale LTE",
          map: mapRSRQ,
          sum: sumRSRQ,
          maximum: maximumRSRQ.toDouble(),
          label: 'RSRQ',
        ),
        const SizedBox(height: 40.0)

      ],
    );
  }
}
