import 'package:flutter/material.dart';
import 'package:bheya_network/models/common/cell_type.dart';

import '../../../config/palette.dart';
import '../../../widget/custom_text.dart';

class CDMWidget extends StatelessWidget {
  final CellType? cellType;
  final int numero;
  const CDMWidget({super.key, required this.cellType, required this.numero});

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
            CustomText("Type ${cellType!.type!}"),
            CustomText("band ${cellType!.cdma!.band!}"),
            CustomText("Uarfcn ${cellType!.cdma!.band!.name}"),
            CustomText("name ${cellType!.cdma!.band!.number}"),
            CustomText("number ${cellType!.cdma!.bid}"),
            CustomText("network iso ${cellType!.cdma!.network!.iso}"),
            CustomText("network mcc ${cellType!.cdma!.network!.mcc}"),
            CustomText("network mnc ${cellType!.cdma!.network!.mnc}"),
            CustomText("signalLTE ${cellType!.cdma!.signalCDMA}"),
            CustomText("cqi ${cellType!.cdma!.signalCDMA!.cdmaEcio}"),
            CustomText("dbm ${cellType!.cdma!.signalCDMA!.cdmaRssi}"),
            CustomText("rsrp ${cellType!.cdma!.signalCDMA!.dbm}"),
            CustomText("rsrpAsu ${cellType!.cdma!.signalCDMA!.evdoEcio}"),
            CustomText("rsrq ${cellType!.cdma!.signalCDMA!.evdoRssi}"),
            CustomText("rssi ${cellType!.cdma!.signalCDMA!.evdoSnr}"),
          ],
        ),
      ],
    );
  }
}
