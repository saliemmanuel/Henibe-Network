import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/app_provider.dart';
import '../../../../widget/custom_text.dart';
import '../../../widget/column_chart.dart';

class GSMRapport extends StatefulWidget {
  const GSMRapport({super.key});

  @override
  State<GSMRapport> createState() => _GSMRapportState();
}

class _GSMRapportState extends State<GSMRapport> {
  Map mapDBM = {};
  Map mapAsu = {};
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
        if (!mapDBM.containsKey(item["dBm"])) {
          mapDBM[item["dBm"]] = 1;
        } else {
          mapDBM[item["dBm"]] += 1;
        }
        if (!mapAsu.containsKey(item["aSU"])) {
          mapAsu[item["aSU"]] = 1;
        } else {
          mapAsu[item["aSU"]] += 1;
        }
      }
    }

    Iterable<dynamic> values = mapDBM.values;
    int sum = values.reduce((sum, value) => sum + value);
    int maximum = values.first;
    for (var element in values) {
      if (maximum < element) maximum = element;
    }

    Iterable<dynamic> valuesAsu = mapAsu.values;
    int sumAsu = valuesAsu.reduce((sum, value) => sum + value);
    int maximumAsu = valuesAsu.first;
    for (var element in values) {
      if (maximum < element) maximumAsu = element;
    }
    return Column(
      children: [
        ColumnChart(
          map: mapDBM,
          sum: sum,
          maximum: maximum.toDouble(),
          label: "DBm",
          typeReseau: "Diagramme DBM du Signale GSM",
        ),
        ColumnChart(
            typeReseau: "Diagramme Asu du Signale GSM",
            map: mapAsu,
            sum: sumAsu,
            maximum: maximumAsu.toDouble(),
            label: "Asu"),
        const SizedBox(height: 40.0)
      ],
    );
  }
}
