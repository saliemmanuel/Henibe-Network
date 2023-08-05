import 'package:flutter/material.dart';
import 'package:bheya_network/cellResponse.dart';
import 'package:bheya_network_example/view/widget/res/gsm_widget.dart';
import 'package:bheya_network_example/view/widget/res/lte_widget.dart';
import 'package:bheya_network_example/view/widget/res/nr_widget.dart';

import '../../config/palette.dart';
import '../../widget/widget.dart';
import 'res/cdma_widget.dart';
import 'res/tdscdma_widget.dart';
import 'res/wcdma_widget.dart';

class NeighboringCellWidget extends StatelessWidget {
  final CellsResponse? cellsResponse;
  const NeighboringCellWidget({super.key, required this.cellsResponse});

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Column(
      children: [
        cellsResponse != null
            ? cellsResponse!.neighboringCellList!.isEmpty
                ? const CustomText("Aucune cellule voisine détecter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          "Nombre Cellule voisine détecter ${cellsResponse!.neighboringCellList!.length}",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                      const Divider(),
                      for (i = 0;
                          i < cellsResponse!.neighboringCellList!.length;
                          i++)
                        if (cellsResponse!.neighboringCellList![i]
                            .toString()
                            .isNotEmpty) ...[
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "gsm".toUpperCase())
                            GSMWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "lte".toUpperCase())
                            LTEWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "nr".toUpperCase())
                            NRWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "tdscdma".toUpperCase())
                            TDSCDMAWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "wcdma".toUpperCase())
                            WCDMAWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          if (cellsResponse!.neighboringCellList![i].type ==
                              "cdma".toUpperCase())
                            CDMWidget(
                                numero: i + 1,
                                cellType:
                                    cellsResponse!.neighboringCellList![i]),
                          const Divider(),
                        ],
                    ],
                  )
            : const CustomText("Error to read data"),
      ],
    );
  }
}
