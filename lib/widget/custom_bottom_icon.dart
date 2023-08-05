import 'package:flutter/material.dart';

import 'widget.dart';

class CustomBottomIcon extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Color labelColors;
  final void Function()? onTap;
  const CustomBottomIcon({
    Key? key,
    this.icon,
    this.label,
    required this.labelColors,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon!, color: Colors.white, size: 20.0),
            CustomText(
              label!,
              color: labelColors,
              fontSize: 10,
            )
          ],
        ),
      ),
    );
  }
}
