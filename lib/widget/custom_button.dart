import 'package:flutter/material.dart';

import '../config/palette.dart';
import 'widget.dart';

class CustomButton extends StatelessWidget {
  final String? textButton;
  final Function()? onPressed;
  final Color? colorButton;
  const CustomButton(
      {Key? key, this.textButton, this.onPressed, required this.colorButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 165.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colorButton ?? Palette.primaryColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: FittedBox(
          fit: BoxFit.cover,
          child: CustomText(textButton ?? " ",
              color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
