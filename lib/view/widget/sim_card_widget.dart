import 'package:flutter/material.dart';
import 'package:sim_data/sim_data.dart';

import '../../widget/custom_text.dart';

class SimCardWidget extends StatelessWidget {
  final SimCard sim;
  const SimCardWidget({super.key, required this.sim});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/sim.png", height: 90.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            const Divider(),
            CustomText('Nom du réseau: ${sim.displayName}'),
            CustomText('Code Pays: ${sim.countryCode}'),
            CustomText('En Roaming: ${sim.isDataRoaming}'),
            CustomText('mcc: ${sim.mcc}'),
            CustomText('mnc: ${sim.mnc}'),
            CustomText('serial: ${sim.serialNumber}'),
            CustomText('slot: ${sim.slotIndex}'),
            CustomText('subscriptionId: ${sim.subscriptionId}')
          ],
        ),
      ],
    );
  }
}
