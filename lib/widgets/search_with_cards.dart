// ignore_for_file: camel_case_types, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';

class Search_with_cards extends StatelessWidget {
  const Search_with_cards({
    Key? key,
    required this.h,
    required this.w,
    required this.text,
    required this.onTap,
    required this.cg,
  }) : super(key: key);

  final double h;
  final double w;
  final String text;
  final List<CategorieGrid> cg;
  final Function onTap;
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
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  childAspectRatio: 1.8,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20),
              padding: EdgeInsets.all(h * 0.01),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: cg.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: w * 0.03),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                    width: w,
                    decoration: BoxDecoration(
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(172, 158, 158, 158),
                              spreadRadius: 0.3,
                              blurRadius: 5,
                              offset: Offset(3, 2)),
                        ],
                        color: const Color(0xffC377FF),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: w,
                        ),
                        FittedBox(
                          // width: w * 0.2,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          child: Text(
                            cg[index].head,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(cg[index].subText,
                            style: TextStyle(
                                fontSize: h * 0.015,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
