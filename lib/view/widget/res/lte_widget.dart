import 'package:flutter/material.dart';
import 'package:bheya_network/models/common/cell_type.dart';

import '../../../config/palette.dart';
import '../../../widget/widget.dart';

class LTEWidget extends StatelessWidget {
  final CellType? cellType;
  final int numero;

  const LTEWidget({super.key, this.cellType, required this.numero});

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
            CustomText("Type ${cellType!.lte!.type}"),
            CustomText(
                "channelNumber ${cellType!.lte!.bandLTE!.channelNumber}"),
            CustomText(
                "downlinkUarfcn ${cellType!.lte!.bandLTE!.downlinkEarfcn}"),
            CustomText("name ${cellType!.lte!.bandLTE!.name}"),
            CustomText("number ${cellType!.lte!.bandLTE!.number}"),
            CustomText("network iso ${cellType!.lte!.network!.iso}"),
            CustomText("network mcc ${cellType!.lte!.network!.mcc}"),
            CustomText("network mnc ${cellType!.lte!.network!.mnc}"),
            CustomText("signalLTE ${cellType!.lte!.signalLTE}"),
            CustomText("cqi ${cellType!.lte!.signalLTE!.cqi}"),
            CustomText("dbm ${cellType!.lte!.signalLTE!.dbm}"),
            CustomText("rsrp ${cellType!.lte!.signalLTE!.rsrp}"),
            CustomText("rsrpAsu ${cellType!.lte!.signalLTE!.rsrpAsu}"),
            CustomText("rsrq ${cellType!.lte!.signalLTE!.rsrq}"),
            CustomText("rssi ${cellType!.lte!.signalLTE!.rssi}"),
            CustomText("rssiAsu${cellType!.lte!.signalLTE!.rssiAsu}"),
            CustomText("snr ${cellType!.lte!.signalLTE!.snr}"),
            CustomText(
                "timingAdvance ${cellType!.lte!.signalLTE!.timingAdvance}"),
            CustomText("bandwidth ${cellType!.lte!.bandwidth}"),
            CustomText("cid ${cellType!.lte!.cid}"),
            CustomText("connectionStatus ${cellType!.lte!.connectionStatus}"),
            CustomText("ecgi ${cellType!.lte!.ecgi}"),
            CustomText(" eci ${cellType!.lte!.eci}"),
            CustomText("enb ${cellType!.lte!.enb}"),
            CustomText("pci ${cellType!.lte!.pci}"),
            CustomText("subscriptionId ${cellType!.lte!.subscriptionId}"),
            CustomText("tac ${cellType!.lte!.tac}"),
          ],
        ),
      ],
    );
  }
}
