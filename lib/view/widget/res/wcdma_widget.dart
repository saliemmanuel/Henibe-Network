import 'package:flutter/material.dart';
import 'package:bheya_network/models/common/cell_type.dart';

import '../../../config/palette.dart';
import '../../../widget/widget.dart';

class WCDMAWidget extends StatelessWidget {
  final CellType? cellType;
  final int numero;

  const WCDMAWidget({super.key, this.cellType, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText("N° $numero",
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Palette.primaryColor),
            Image.asset("assets/bts.png"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("Type ${cellType!.type}"),
                CustomText(
                    "Number ${cellType!.wcdma!.bandWCDMA!.channelNumber}"),
                CustomText(
                    "Uarfcn ${cellType!.wcdma!.bandWCDMA!.downlinkUarfcn}"),
                CustomText("name ${cellType!.wcdma!.bandWCDMA!.name}"),
                CustomText("number ${cellType!.wcdma!.bandWCDMA!.number}"),
                CustomText("iso ${cellType!.wcdma!.network!.iso}"),
                CustomText("mcc ${cellType!.wcdma!.network!.mcc}"),
                CustomText("mnc ${cellType!.wcdma!.network!.mnc}"),
                CustomText("dbm ${cellType!.wcdma!.signalWCDMA!.dbm}"),
                CustomText("ecio ${cellType!.wcdma!.signalWCDMA!.ecio}"),
                CustomText("ecno ${cellType!.wcdma!.signalWCDMA!.ecno}"),
                CustomText("rscp ${cellType!.wcdma!.signalWCDMA!.rscp}"),
                CustomText("rscpAsu ${cellType!.wcdma!.signalWCDMA!.rscpAsu}"),
                CustomText("rssi ${cellType!.wcdma!.signalWCDMA!.rssi}"),
                CustomText("rssiAsu ${cellType!.wcdma!.signalWCDMA!.rssiAsu}"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
