import 'package:flutter/material.dart';
import 'package:bheya_network/models/common/cell_type.dart';

import '../../../config/palette.dart';
import '../../../widget/widget.dart';

class NRWidget extends StatelessWidget {
  final CellType? cellType;
  final int numero;

  const NRWidget({super.key, this.cellType, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText("N° $numero",
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Palette.primaryColor),
        Image.asset("assets/bts.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("Type ${cellType!.nr!.type}"),
            CustomText("bandWCDMA ${cellType!.nr!.bandNR}"),
            CustomText("nci ${cellType!.nr!.nci}"),
            CustomText("iso ${cellType!.nr!.network!.iso}"),
            CustomText("mcc ${cellType!.nr!.network!.mcc}"),
            CustomText("mnc ${cellType!.nr!.network!.mnc}"),
            CustomText("network iso ${cellType!.nr!.network!.iso}"),
            CustomText("network mcc ${cellType!.nr!.network!.mcc}"),
            CustomText("network mnc ${cellType!.nr!.network!.mnc}"),
            CustomText("csiRsrp ${cellType!.nr!.signalNR!.csiRsrp}"),
            CustomText("csiRsrpAsu ${cellType!.nr!.signalNR!.csiRsrpAsu}"),
            CustomText("csiRsrq ${cellType!.nr!.signalNR!.csiRsrq}"),
            CustomText("csiSinr ${cellType!.nr!.signalNR!.csiSinr}"),
            CustomText("dbm ${cellType!.nr!.signalNR!.dbm}"),
            CustomText("ssRsrp ${cellType!.nr!.signalNR!.ssRsrp}"),
            CustomText("ssRsrpAsu ${cellType!.nr!.signalNR!.ssRsrpAsu}"),
            CustomText("ssRsrq ${cellType!.nr!.signalNR!.ssRsrq}"),
            CustomText("ssSinr ${cellType!.nr!.signalNR!.ssSinr}"),
            CustomText("tac ${cellType!.nr!.tac}"),
            CustomText("pci ${cellType!.nr!.pci}"),
          ],
        ),
      ],
    );
  }
}
