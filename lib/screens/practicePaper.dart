// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';
import 'package:smart_acadamy/screens/instructionPage.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PracticePaper extends StatefulWidget {
  const PracticePaper({Key? key}) : super(key: key);
  static const id = "/practicePaper";

  @override
  State<PracticePaper> createState() => _PracticePaperState();
}

class _PracticePaperState extends State<PracticePaper> {
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
      CategorieGrid("Algebra", "123/200"),
      CategorieGrid("Algebra", "123/200"),
      CategorieGrid("Algebra", "123/200"),
      CategorieGrid("Algebra", "123/200"),
      CategorieGrid("Algebra", "123/200"),
      CategorieGrid("Algebra", "123/200"),
    ];
    return pageUI(
      Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  "ALGEBRA",
                  style: TextStyle(
                      fontSize: h * 0.022,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1),
                ),
                Text("123/200",
                    style: TextStyle(
                        letterSpacing: 1.1,
                        fontSize: h * 0.017,
                        fontWeight: FontWeight.w600))
              ],
            ),
            backgroundColor: const Color(0xff7F63FE),
          ),
          body: Search_with_cards(
              h: h,
              w: w,
              text: "Practice paper in Algebra",
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.topToBottom,
                        child: const InstructionPage()));
              },
              cg: cg)),
    );
  }
}
