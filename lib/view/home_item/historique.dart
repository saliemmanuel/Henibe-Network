import 'package:bheya_network_example/db/sqflite.dart';
import 'package:bheya_network_example/provider/app_provider.dart';
import 'package:bheya_network_example/view/home_item/rapport.dart';
import 'package:bheya_network_example/widget/custom_dialogue_card.dart';
import 'package:bheya_network_example/widget/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/custom_text.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).providerListHistorique();
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Historique",
            fontWeight: FontWeight.bold, fontSize: 20.0),
        actions: [
          IconButton.filled(
              tooltip: "Map", onPressed: () {}, icon: const Icon(Icons.map)),
          const PopUpMen(
            menuList: [
              PopupMenuItem(
                  value: "Telecharger_csv",
                  height: 8.0,
                  child: ListTile(
                    leading: Icon(Icons.save_alt_rounded),
                    title: Text("Télécharger (.csv)"),
                  )),
              PopupMenuItem(
                  value: "Rapport",
                  height: 8.0,
                  child: ListTile(
                    leading: Icon(Icons.upload_file_sharp),
                    title: Text("Rapport"),
                  )),
              PopupMenuItem(
                  value: "Effacer",
                  height: 8.0,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text("Effacer"),
                  )),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Scrollbar(
        child: Consumer<AppProvider>(
          builder: (context, value, child) {
            if (value.listHistorique == null) {
              return const Center(child: CustomText("Chargement..."));
            } else {
              return ListView.builder(
                itemCount: value.listHistorique == null
                    ? 0
                    : value.listHistorique!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.history),
                      title: sendSpecifiqueInfo(value.listHistorique![index]),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  sendSpecifiqueInfo(var data) {
    var date =
        "${data['year']}-${data['month']}-${data['day']} ${data['hour']}:${data['minutes']}:${data['seconds']}";
    if (data["networktype"] == "gsm".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} DBm: ${data["dBm"]}, Asu: ${data["dBm"]},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]} $date");
    }

    if (data["networktype"] == "lte".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} RSRQ: ${data["rSRQ"]}, RSRP: ${data["rSRP"]},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]} $date");
    }

    if (data["networktype"] == "nr".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} DBm: ${data["dBm"]},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]} $date");
    }

    if (data["networktype"] == "tdscdma".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} Dbm: ${data["dBm"]},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]}  $date");
    }

    if (data["networktype"] == "wcdma".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} Dbm: ${data["dBm"]},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]}  $date");
    }

    if (data["networktype"] == "cdma".toUpperCase()) {
      return CustomText(
          "${data["networktype"]} Dbm: ${data.signalCDMA.dbm},  mnc: ${data["mnc"]}, mcc: ${data["mcc"]}   $date");
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
          if (value == "Telecharger_csv") {
            Provider.of<AppProvider>(context, listen: false)
                .generateCSV(context);
          }
          if (value == "Rapport") {
            pushNewPage(const RapportScreen(), context);
          }
          if (value == "Effacer") {
            customDialogue(
                context, "Message", "Vous êtez sur de vouloire éffacer",
                onPressed: () {
              deleteDatabase(context);
              Navigator.pop(context);
            }, text: "Confirmer");
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        itemBuilder: ((context) => menuList),
        icon: icon);
  }
}
