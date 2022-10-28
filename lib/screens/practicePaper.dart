import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';
import 'package:smart_acadamy/screens/instructionPage.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:page_transition/page_transition.dart';

class PracticePaper extends StatelessWidget {
  const PracticePaper({Key? key}) : super(key: key);
  static const id = "/practicePaper";
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
    return Scaffold(
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
          backgroundColor: Color(0xff7F63FE),
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
            cg: cg));
  }
}
