import 'package:flutter/material.dart';

import 'custom_text.dart';

class ItemMap extends StatelessWidget {
  final Function()? onTap;
  final String? label;

  const ItemMap({Key? key, this.onTap, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.show_chart_sharp,
              color: Colors.white,
              size: 25.0,
            ),
            const SizedBox(height: 10.0),
            CustomText(
              label ?? "",
              fontSize: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
