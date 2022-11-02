import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.floatOnTap,
    required this.w,
    required this.h,
    required this.floatingButtonText,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  final Function floatOnTap;
  final double w;
  final double h;
  final String floatingButtonText;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        floatOnTap();
      },
      child: Container(
        height: h * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            // ignore: prefer_const_constructors
            BoxShadow(
                color: const Color.fromARGB(199, 158, 158, 158),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(3, 3))
          ],
          color: buttonColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: w * 0.08, vertical: h * 0.014),
        child: Center(
          child: Text(
            floatingButtonText,
            style: TextStyle(
                color: textColor,
                letterSpacing: h * 0.002,
                fontSize: h * 0.02,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
