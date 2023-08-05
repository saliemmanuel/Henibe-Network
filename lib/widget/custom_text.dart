import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;

  const CustomText(this.text,
      {Key? key,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text ?? "",
      style: GoogleFonts.ubuntuMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ));
}
