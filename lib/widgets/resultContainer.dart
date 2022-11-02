// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ResultContainers extends StatelessWidget {
  const ResultContainers({
    Key? key,
    required this.h,
    required this.w,
    required this.containerColor,
    required this.textColor,
    required this.text,
    required this.text2,
  }) : super(key: key);

  final double h;
  final double w;
  final Color containerColor;
  final Color textColor;
  final String text;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.03),
      height: h * 0.07,
      width: w * 0.9,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: h * 0.02,
                fontWeight: FontWeight.bold),
          ),
          Text(text2,
              style: TextStyle(
                  color: textColor,
                  fontSize: h * 0.02,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
