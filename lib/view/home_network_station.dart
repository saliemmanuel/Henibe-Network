import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bheya_network_example/provider/app_provider.dart';
import 'package:bheya_network_example/view/home_item/accueil.dart';
import 'package:bheya_network_example/view/home_item/cellule.dart';
import 'package:bheya_network_example/view/home_item/graphique.dart';
import 'package:bheya_network_example/view/home_item/historique.dart';
import '../config/palette.dart';
import 'home_item/profil.dart';

class HomeNetworkStation extends StatefulWidget {
  const HomeNetworkStation({super.key});

  @override
  State<HomeNetworkStation> createState() => _HomeNetworkStationState();
}

class _HomeNetworkStationState extends State<HomeNetworkStation> {
  var topIndex = 0;

  var item = [
    const Accueil(),
    const Cellule(),
    const Graphique(),
    const Historique(),
    const Profil()
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false)
        .providerWifiCellularLevelStrength();
    Provider.of<AppProvider>(context, listen: false).providerCellInfo();
    Provider.of<AppProvider>(context, listen: false).providerGetLocation();
    Provider.of<AppProvider>(context, listen: false).providerCheckGps();
    Provider.of<AppProvider>(context, listen: false).testSpedd();
    return Scaffold(
      body: item[topIndex],
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
              tooltip: "Profil",
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ]),
    );
  }
}
