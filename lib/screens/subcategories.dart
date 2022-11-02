// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'dart:ui';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/practicePaper.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:provider/provider.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);
  static const id = "/subCat";

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    List<CategorieGrid> cg = [
      CategorieGrid("Linear Equation", "123/200"),
      CategorieGrid("Square Roots", "123/200"),
      CategorieGrid("Cube Roots", "123/200"),
      CategorieGrid("Identities", "123/200"),
      CategorieGrid("Factorization", "123/200"),
      CategorieGrid("Direct and Inverse properties", "123/200"),
    ];
    return pageUI(
      Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  "MATHS",
                  style: TextStyle(
                      fontSize: h * 0.022,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1),
                ),
                Text("123/200",
                    style: TextStyle(
                        letterSpacing: 1.1,
                        fontSize: h * 0.017,
                        fontWeight: FontWeight.w900))
              ],
            ),
            backgroundColor: const Color(0xff7F63FE),
          ),
          body: Search_with_cards(
            h: h,
            w: w,
            text: "Sub Categories",
            cg: cg,
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: const PracticePaper()));
            },
          )),
    );
  }
}
// class subjContainers{
//   subjContainers()
// }