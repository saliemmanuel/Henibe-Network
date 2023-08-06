import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../config/palette.dart';
import '../../widget/custom_text.dart';

class Profil extends StatefulWidget {
  final Function? onStart;
  const Profil({super.key, required this.onStart});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String text = "Arrêter le service";
  var isRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Profil",
            fontWeight: FontWeight.bold, fontSize: 20.0),
        actions: const [
          PopUpMen(
            menuList: [
              PopupMenuItem(
                  value: "apropos",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text("A-propos"),
                  )),
              PopupMenuItem(
                  value: "deconnexion",
                  height: 15.0,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Déconnexion"),
                  )),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: !isRunning ? Colors.red : Palette.primaryColor,
                child: MaterialButton(
                    child: Text(text,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white)),
                    onPressed: () async {
                      final service = FlutterBackgroundService();
                      var isRunning = await service.isRunning();
                      if (isRunning) {
                        service.invoke("stopService");
                      } else {
                        service.startService();
                      }

                      if (!isRunning) {
                        text = "Arrêter le service";
                      } else {
                        text = "Lancer le service";
                      }
                      setState(() {});
                    })),
          )
        ],
      ),
    );
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
        if (value == "apropos") {}
        if (value == "deconnexion") {}
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
