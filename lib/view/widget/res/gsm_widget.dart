import 'package:flutter/material.dart';
import 'package:bheya_network/models/common/cell_type.dart';

import '../../../config/palette.dart';
import '../../../widget/widget.dart';

class GSMWidget extends StatelessWidget {
  final CellType? cellType;
  final int numero;

  const GSMWidget({super.key, required this.cellType, required this.numero});

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
            CustomText("Type ${cellType!.gsm!.type}"),
            CustomText(
                "channelNumber ${cellType!.gsm!.bandGSM!.channelNumber}"),
            CustomText("arfcn ${cellType!.gsm!.bandGSM!.arfcn}"),
            CustomText("name ${cellType!.gsm!.bandGSM!.name}"),
            CustomText("number ${cellType!.gsm!.bandGSM!.number}"),
            CustomText("network iso ${cellType!.gsm!.network!.iso}"),
            CustomText("network mcc ${cellType!.gsm!.network!.mcc}"),
            CustomText("network mnc ${cellType!.gsm!.network!.mnc}"),
            CustomText(
                "bitErrorRate ${cellType!.gsm!.signalGSM!.bitErrorRate}"),
            CustomText("dbm ${cellType!.gsm!.signalGSM!.dbm}"),
            CustomText("rssi ${cellType!.gsm!.signalGSM!.rssi}"),
            CustomText(
                "timingAdvance ${cellType!.gsm!.signalGSM!.timingAdvance}"),
          ],
        ),
      ],
    );
  }
}
