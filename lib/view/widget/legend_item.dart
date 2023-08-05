import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color? color;
  final String data;
  const LegendItem({super.key, this.color, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(30.0)),
          ),
          const SizedBox(width: 10.0),
          Text(
            data,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
