import 'package:bheya_network_example/view/widget/sim_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../provider/app_provider.dart';
import '../../widget/widget.dart';
import '../widget/neighboring_cell_widget.dart';
import '../widget/primary_cell_widget.dart';

class Cellule extends StatefulWidget {
  const Cellule({super.key});

  @override
  State<Cellule> createState() => _CelluleState();
}

class _CelluleState extends State<Cellule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText(
        "Sim détail",
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      )),
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
                    if (value.simData == null)
                      const CustomText("Aucune Sim détectée",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.red)
                    else
                      const CustomText("Sim détectée",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                    if (value.simData != null)
                      Column(
                        children: [
                          const Divider(),
                          Column(
                              children: value.simData!.cards
                                  .map((sim) => SimCardWidget(sim: sim))
                                  .toList()),
                        ],
                      ),
                    const Divider(),
                    PrimaryCellWidget(cellsResponse: value.cellsResponse),
                    NeighboringCellWidget(cellsResponse: value.cellsResponse),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
