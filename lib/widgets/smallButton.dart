// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.h,
    required this.w,
    required this.onTap,
    required this.buttonText,
    required this.color,
  }) : super(key: key);

  final double h;
  final double w;
  final Function onTap;
  final String buttonText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: h * 0.05,
        width: w * 0.2,
        // ignore: prefer_const_literals_to_create_immutables
        decoration: BoxDecoration(boxShadow: [
          // ignore: prefer_const_constructors
          BoxShadow(
              color: const Color.fromARGB(47, 4, 4, 4),
              // blurRadius: 60,
              spreadRadius: 0.3,
              offset: const Offset(0, 0))
        ], color: color, borderRadius: BorderRadius.circular(13)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: h * 0.02),
          ),
        ),
      ),
    );
  }
}
