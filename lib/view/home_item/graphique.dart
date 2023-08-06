import 'package:bheya_network_example/view/home_item/rapport/rapport.dart';
import 'package:bheya_network_example/view/widget/legend_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/palette.dart';
import '../../provider/app_provider.dart';
import '../../widget/custom_text.dart';
import '../../widget/route.dart';
import '../widget/chart.dart';
import '../widget/primary_cell_widget.dart';

class Graphique extends StatefulWidget {
  const Graphique({super.key});

  @override
  State<Graphique> createState() => _GraphiqueState();
}

class _GraphiqueState extends State<Graphique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const CustomText(
            "Graphique",
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          actions: const [
            PopUpMen(
              menuList: [
                PopupMenuItem(
                    value: "Rapport",
                    height: 8.0,
                    child: ListTile(
                      leading: Icon(Icons.map),
                      title: Text("Rapport"),
                    )),
              ],
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Consumer<AppProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText("Information de la sim",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                      const Divider(),
                      CustomText('networkISO: ${value.networkCountryISO}'),
                      const Divider(),
                      CustomText('simOperator: ${value.simOperator}'),
                      const Divider(),
                      CustomText(
                          'mobileNetworkCode: ${value.mobileNetworkCode}'),
                      const Divider(),
                      CustomText(
                          'mobileCountryCode: ${value.mobileCountryCode}'),
                      const Divider(),
                      CustomText('SIMCountryISO: ${value.simCountryISO}'),
                      const Divider(),
                      CustomText('softwareVersion: ${value.softwareVersion}'),
                      const Divider(),
                      CustomText('voiceMailNumber: ${value.voiceMailNumber}'),
                      const Divider(),
                      CustomText(
                          'networkGeneration: ${value.networkGeneration}'),
                      const Divider(),
                      CustomText('cid: ${value.cid}'),
                      const Divider(),
                      CustomText('lac: ${value.lac}'),
                      const Divider(),
                      PrimaryCellWidget(cellsResponse: value.cellsResponse),
                      const SizedBox(height: 10.0),
                      CustomText(
                          value.cellsResponse != null
                              ? "Type signal : ${value.cellsResponse!.primaryCellList![0].type}"
                              : "Aucune cellule détectée",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                      const SizedBox(height: 15.0),
                      getTypeResau(value.cellsResponse!.primaryCellList![0]),
                      const CustomText("Information du téléphone",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                      const Divider(),
                      CustomText('DeviceId: ${value.subscriberID}'),
                      const Divider(),
                      CustomText('Version: ${value.andoidVersion}'),
                      const Divider(),
                      CustomText('Model: ${value.model}'),
                      const Divider(),
                      CustomText('sdkInt: ${value.sdkInt}'),
                      const Divider(),
                      CustomText('id: ${value.idPhone}'),
                      const Divider(),
                      CustomText('androidId: ${value.androidId}'),
                      const Divider(),
                      CustomText('Imei: ${value.simSerialNumber}'),
                      const Divider(),
                      CustomText('PhoneNumber: ${value.simNumber}'),
                      const Divider(),
                      CustomText('brand: ${value.brand}'),
                      const Divider(),
                      const SizedBox(height: 45)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  getTypeResau(var data) {
    if (data.type == "gsm".toUpperCase()) {
      return Column(
        children: [
          CustomText("Graphe Dbm ${data.gsm.signalGSM.dbm}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child:
                Chart(ordoneeLabel: "Dbm", value: data.gsm.signalGSM.dbm ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm)	≥ -65	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-65 à -75	Très bon", color: Colors.lightGreen),
                  LegendItem(data: "-85 à -95	Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-95 à -120	Mauvais", color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const Divider(),
          CustomText("Graphe Asu ${data.gsm.signalGSM.dbm}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child:
                Chart(ordoneeLabel: "Asu", value: data.gsm.signalGSM.dbm ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm)	≥ -65	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-65 à -75	Très bon", color: Colors.lightGreen),
                  LegendItem(data: "-85 à -95	Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-95 à -120	Mauvais", color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }

    if (data.type == "lte".toUpperCase()) {
      return Column(
        children: [
          CustomText("Graphe RSRQ ${data.lte.signalLTE.rsrq}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child: Chart(
                ordoneeLabel: "RSRQ", value: data.lte.signalLTE.rsrq ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "RSRQ en dB	-5 à -10 	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(data: "-10 à -15	Bon", color: Colors.lightGreen),
                  LegendItem(
                      data: "-15 à -20	Faible", color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const Divider(),
          CustomText("Graphe RSRP ${data.lte.signalLTE.rsrp}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child: Chart(
                ordoneeLabel: "RSRP", value: data.lte.signalLTE.rsrp ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "RSRP en dBm	≥-80 	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(data: "	-80 à -90 	Bon", color: Colors.lightGreen),
                  LegendItem(
                      data: "-90 à -100 	Faible", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-100 à -140	Pas de connexion",
                      color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }

    if (data.type == "nr".toUpperCase()) {
      return Column(
        children: [
          SizedBox(
            height: 206.0,
            child: Chart(ordoneeLabel: "dBm", value: data.nr.signalNR.dbm ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm)	≥ -65	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-65 à -75	Très bon", color: Colors.lightGreen),
                  LegendItem(data: "-85 à -95	Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-95 à -120	Mauvais", color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }

    if (data.type == "tdscdma".toUpperCase()) {
      return Column(
        children: [
          CustomText("Graphe Dbm ${data.tdscdma.signalTDSCDMA.dbm}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child: Chart(
                ordoneeLabel: "dBm",
                value: data.tdscdma.signalTDSCDMA.dbm ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Legende", style: TextStyle(color: Colors.white)),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm) ≥ -75	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-75 à -85 Très bon", color: Colors.lightGreen),
                  LegendItem(data: "	-85 à -95	Bon", color: Colors.lightGreen),
                  LegendItem(
                      data: "-95 à -105 Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-105 à -115	Mauvais", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-115 à -120	Très mauvais",
                      color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }

    if (data.type == "wcdma".toUpperCase()) {
      return Column(
        children: [
          CustomText("Graphe Dbm ${data.wcdma.signalWCDMA.dbm}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
              height: 206.0,
              child: Chart(
                  ordoneeLabel: "dBm", value: data.wcdma.signalWCDMA.dbm)),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm) ≥ -75	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-75 à -85 Très bon", color: Colors.lightGreen),
                  LegendItem(data: "	-85 à -95	Bon", color: Colors.lightGreen),
                  LegendItem(
                      data: "-95 à -105 Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-105 à -115	Mauvais", color: Colors.lightGreen),
                  LegendItem(
                      data: "	-115 à -120	Très mauvais",
                      color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0)
        ],
      );
    }

    if (data.type == "cdma".toUpperCase()) {
      return Column(
        children: [
          CustomText("Graphe Dbm ${data.cdma.signalCDMA.dbm}",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Palette.primaryColor),
          SizedBox(
            height: 206.0,
            child: Chart(
                ordoneeLabel: "Dbm", value: data.cdma.signalCDMA.dbm ?? 0),
          ),
          Container(
            color: Colors.grey.shade800,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legende",
                    style: TextStyle(color: Colors.white),
                  ),
                  LegendItem(
                      data: "DBm ou Rxlev (dBm)	≥ -75	Excellent",
                      color: Colors.lightGreen),
                  LegendItem(
                      data: "-75 à -85	Très bon", color: Colors.lightGreen),
                  LegendItem(
                      data: "-95 à -105	Moyen", color: Colors.lightGreen),
                  LegendItem(
                      data: "-105 à -115	Mauvais", color: Colors.lightGreen),
                  LegendItem(
                      data: "-115 à -120	Très mauvais",
                      color: Colors.lightGreen),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      );
    }
    setState(() {});
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == "Rapport") {
            pushNewPage(const RapportScreen(), context);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        itemBuilder: ((context) => menuList),
        icon: icon);
  }
}
