import 'package:bheya_network_example/view/home_item/rapport/widget/cdma_rapport.dart';
import 'package:bheya_network_example/view/home_item/rapport/widget/gsm_rapport.dart';
import 'package:bheya_network_example/view/home_item/rapport/widget/lte_rapport.dart';
import 'package:bheya_network_example/view/home_item/rapport/widget/rn_rapport.dart';
import 'package:bheya_network_example/view/home_item/rapport/widget/tdscdma_rapport.dart';
import 'package:bheya_network_example/view/home_item/rapport/widget/wcdma_rapport.dart';
import 'package:bheya_network_example/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';
import '../../../widget/custom_text.dart';

class RapportScreen extends StatefulWidget {
  const RapportScreen({super.key});

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  Map typeReseau = {};

  @override
  void initState() {
    getListTypeReseau(
        Provider.of<AppProvider>(context, listen: false).listHistorique);
    super.initState();
  }

  initRapportList() async {
    setState(() {});
  }

  getListTypeReseau(List<dynamic>? data) {
    for (var item in data!) {
      if (!typeReseau.containsKey(item["networktype"])) {
        typeReseau[item["networktype"]] = 1;
      } else {
        typeReseau[item["networktype"]] += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Rapport",
            fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      body: ListView(
          children: typeReseau.keys
              .map((e) => InkWell(
                    child: Card(
                      child: ListTile(
                        title: Text(e),
                        trailing: const Icon(Icons.arrow_right_rounded),
                      ),
                    ),
                    onTap: () {
                      if (e == "gsm".toUpperCase()) {
                        pushNewPage(const GSMRapport(), context);
                      }

                      if (e == "lte".toUpperCase()) {
                        pushNewPage(const LTERapport(), context);
                      }

                      if (e == "nr".toUpperCase()) {
                        pushNewPage(const NRRapport(), context);
                      }

                      if (e == "tdscdma".toUpperCase()) {
                        pushNewPage(const TDSCDMARapport(), context);
                      }

                      if (e == "wcdma".toUpperCase()) {
                        pushNewPage(const WDMARapport(), context);
                      }

                      if (e == "cdma".toUpperCase()) {
                        pushNewPage(const CDMARapport(), context);
                      }
                    },
                  ))
              .toList()),
    );
  }
}
