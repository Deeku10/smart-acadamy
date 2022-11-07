// ignore_for_file: camel_case_types, prefer_const_constructors, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';

class Search_with_cards extends StatelessWidget {
  const Search_with_cards({
    Key? key,
    required this.h,
    required this.w,
    required this.text,
    required this.catWidget,
  }) : super(key: key);

  final double h;
  final double w;
  final String text;
  final Widget catWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: h * 0.06,
          width: w,
        ),
        Container(
          height: h * 0.065,
          width: w * 0.85,
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Search in Categories',
                hintText: 'EX:Math'),
            cursorColor: Color(0xffC377FF),
          ),
          decoration: BoxDecoration(
              color: Color(0xffE7E7E7),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Row(
          children: [
            SizedBox(
              width: w * 0.06,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: h * 0.026,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        Expanded(child: catWidget)
      ],
    );
  }
}
