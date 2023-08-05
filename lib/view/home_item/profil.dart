import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widget/custom_text.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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
