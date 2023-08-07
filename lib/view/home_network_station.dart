import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:bheya_network_example/provider/app_provider.dart';
import 'package:bheya_network_example/view/home_item/accueil.dart';
import 'package:bheya_network_example/view/home_item/cellule.dart';
import 'package:bheya_network_example/view/home_item/graphique.dart';
import 'package:bheya_network_example/view/home_item/historique.dart';
import '../config/palette.dart';
import 'home_item/map/map.dart';
import 'home_item/profil.dart';

class HomeNetworkStation extends StatefulWidget {
  final Function? onStart;

  const HomeNetworkStation({super.key, required this.onStart});

  @override
  State<HomeNetworkStation> createState() => _HomeNetworkStationState();
}

class _HomeNetworkStationState extends State<HomeNetworkStation>
    with WidgetsBindingObserver {
  var topIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  runBackService() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.detached == state) {
      print("\n");
      print("\n");
      print("\n");
      print("\n");
      print("oooooooooooooooooooooooooooooooooDetached");
      runBackService();
    }

    if (AppLifecycleState.inactive == state) {
      print("\n");
      print("\n");
      print("\n");
      print("\n");
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Inactive");
      runBackService();
    }

    if (AppLifecycleState.paused == state) {
      print("\n");
      print("\n");
      print("\n");
      print("\n");
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeee Pause");
      runBackService();
    }

    if (AppLifecycleState.resumed == state) {
      print("ffffffffffffffffffffffffffff Resume");
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false)
        .providerWifiCellularLevelStrength();
    Provider.of<AppProvider>(context, listen: false).providerCellInfo();
    Provider.of<AppProvider>(context, listen: false).providerGetLocation();
    Provider.of<AppProvider>(context, listen: false).providerCheckGps();
    Provider.of<AppProvider>(context, listen: false).testSpedd();
    return Consumer<AppProvider>(
      builder: (context, value, child) => Scaffold(
        body: [
          const Accueil(),
          const Cellule(),
          const Graphique(),
          const Historique(),
          MapsScreen(listHistorique: value.listHistorique)
        ][topIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            enableFeedback: true,
            useLegacyColorScheme: true,
            backgroundColor: Colors.white,
            selectedItemColor: Palette.primaryColor,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            showUnselectedLabels: true,
            currentIndex: topIndex,
            onTap: (i) {
              topIndex = i;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                tooltip: "Accueil",
                icon: Icon(Icons.home),
                label: "Accueil",
              ),
              BottomNavigationBarItem(
                tooltip: "Cellule",
                icon: Icon(Icons.attractions_rounded),
                label: "Cellule",
              ),
              BottomNavigationBarItem(
                tooltip: "Graphique",
                icon: Icon(Icons.wysiwyg),
                label: "Graphique",
              ),
              BottomNavigationBarItem(
                tooltip: "Historique",
                icon: Icon(Icons.history),
                label: "Historique",
              ),
              BottomNavigationBarItem(
                tooltip: "Carte",
                icon: Icon(Icons.map),
                label: "Carte",
              ),
            ]),
      ),
    );
  }
}

// Consumer<AppProvider>(
//       builder: (context, vall, child) => PopupMenuButton(
//           onSelected: (value) {
//             if (value == "Telecharger_csv") {
//               Provider.of<AppProvider>(context, listen: false)
//                   .generateCSV(context);
//             }
//             if (value == "map") {
//               pushNewPage(
//                   MapsScreen(listHistorique: vall.listHistorique), context);
//             }
//             if (value == "Effacer") {
//               customDialogue(
//                   context, "Message", "Vous êtez sur de vouloire tous éffacer?",
//                   onPressed: () {
//                 deleteDatabase(context);
//                 Navigator.pop(context);
//               }, text: "Confirmer");
//             }
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           itemBuilder: ((context) => menuList),
//           icon: icon),
//     )