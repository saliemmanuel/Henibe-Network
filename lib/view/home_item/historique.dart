import 'package:bheya_network_example/provider/app_provider.dart';
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
                  value: "Sauvegarder",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.save),
                    title: Text("Sauvegarder"),
                  )),
              PopupMenuItem(
                  value: "Telecharger_csv",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.save_alt_rounded),
                    title: Text("Télécharger (.csv)"),
                  )),
              PopupMenuItem(
                  value: "Telecharger_pdf",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.save_alt_rounded),
                    title: Text("Télécharger (.pdf)"),
                  )),
              PopupMenuItem(
                  value: "Telecharger_xlsx",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.save_alt_rounded),
                    title: Text("Télécharger (.xlsx)"),
                  )),
              PopupMenuDivider(),
              PopupMenuItem(
                  value: "Telecharger_xlsx",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.upload_file_sharp),
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
              return Column(
                  children: List.generate(
                      55,
                      (index) => Card(
                            child: ListTile(
                              leading: const Icon(Icons.history),
                              title: CustomText(sendSpecifiqueInfo(getTypeResau(
                                  value.cellsResponse!.primaryCellList![0]))),
                            ),
                          )));
            },
          ),
        ),
      ),
    );
  }

  getTypeResau(var data) {
    if (data.type == "gsm".toUpperCase()) {
      return data.gsm;
    }
    if (data.type == "lte".toUpperCase()) {
      return data.lte;
    }
    if (data.type == "nr".toUpperCase()) {
      return data.nr;
    }
    if (data.type == "tdscdma".toUpperCase()) {
      return data.tdscdma;
    }
    if (data.type == "wcdma".toUpperCase()) {
      return data.wcdma;
    }
    if (data.type == "cdma".toUpperCase()) {
      return data.cdma;
    }
  }

  sendSpecifiqueInfo(var data) {
    var date =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().minute}-${DateTime.now().second}";
    if (data.type == "gsm".toUpperCase()) {
      return "${data.type} DBm: ${data.signalGSM.dbm}, Asu: ${data.signalGSM.dbm}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
    }

    if (data.type == "lte".toUpperCase()) {
      return "RSRQ: ${data.signalLTE.rsrq}, RSRP: ${data.signalLTE.rsrp}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
    }

    if (data.type == "nr".toUpperCase()) {
      return "DBm: ${data.signalNR.dbm}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
    }

    if (data.type == "tdscdma".toUpperCase()) {
      return "Dbm: ${data.signalTDSCDMA.dbm}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
    }

    if (data.type == "wcdma".toUpperCase()) {
      return "DBm: ${data.signalWCDMA.dbm}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
    }

    if (data.type == "cdma".toUpperCase()) {
      return "Dbm: ${data.signalCDMA.dbm}, iso: ${data.network.iso}, mnc: ${data.network.mnc}, mcc: ${data.network.mcc} $date";
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
        if (value == "Telecharger_xlsx") {
          Provider.of<AppProvider>(context, listen: false)
              .exportToExcel(context);
        }
        if (value == "Telecharger_pdf") {}
        if (value == "Telecharger_csv") {}
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
