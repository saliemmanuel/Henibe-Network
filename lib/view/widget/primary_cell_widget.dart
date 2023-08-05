import 'package:flutter/material.dart';
import 'package:bheya_network/cellResponse.dart';
import 'package:bheya_network_example/view/widget/res/gsm_widget.dart';

import '../../config/palette.dart';
import '../../widget/widget.dart';
import 'res/cdma_widget.dart';
import 'res/lte_widget.dart';
import 'res/nr_widget.dart';
import 'res/tdscdma_widget.dart';
import 'res/wcdma_widget.dart';

class PrimaryCellWidget extends StatelessWidget {
  final CellsResponse? cellsResponse;

  const PrimaryCellWidget({super.key, this.cellsResponse});

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Column(
      children: [
        cellsResponse != null
            ? cellsResponse!.primaryCellList!.isEmpty
                ? const Padding(
                  padding:  EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child:  CustomText("Aucune cellule Principale",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.red),
                )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText("cellule Principale",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Palette.primaryColor),
                      const Divider(),
                      if (cellsResponse!.primaryCellList![i]
                          .toString()
                          .isNotEmpty) ...[
                        if (cellsResponse!.primaryCellList![i].type ==
                            "gsm".toUpperCase())
                          GSMWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        if (cellsResponse!.primaryCellList![i].type ==
                            "lte".toUpperCase())
                          LTEWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        if (cellsResponse!.primaryCellList![i].type ==
                            "nr".toUpperCase())
                          NRWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        if (cellsResponse!.primaryCellList![i].type ==
                            "tdscdma".toUpperCase())
                          TDSCDMAWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        if (cellsResponse!.primaryCellList![i].type ==
                            "wcdma".toUpperCase())
                          WCDMAWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        if (cellsResponse!.primaryCellList![i].type ==
                            "cdma".toUpperCase())
                          CDMWidget(
                              numero: i + 1,
                              cellType: cellsResponse!.primaryCellList![i]),
                        const Divider(),
                      ],
                    ],
                  )
            : const CustomText("Error to read data"),
      ],
    );
  }
}
