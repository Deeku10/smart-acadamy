// ignore: file_names
import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/screens/examPage.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:page_transition/page_transition.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);
  static const id = "/instructionPage";
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // padding: const EdgeInsets.only(bottom: 100),
            height: h * 0.35,
            width: w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/instructionHeader.png"),
                    fit: BoxFit.fill)),
          ),
          Container(
            margin: EdgeInsets.only(top: h * 0.3),
            padding: EdgeInsets.symmetric(horizontal: w * 0.07),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            height: h * 0.77,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: 5,
                itemBuilder: ((context, index) => Text(
                      "${index + 1}.Lorem ipsum dolor sit amet, coectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.",
                      style: TextStyle(
                          fontSize: h * 0.019, fontWeight: FontWeight.w600),
                    ))),
          ),
          Padding(
            padding: EdgeInsets.only(top: h * 0.8),
            child: Button(
              floatOnTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: ExamPage()));
              },
              h: h,
              w: w,
              floatingButtonText: 'I understood,start the exam',
              textColor: Colors.white,
              buttonColor: Color(0xff9700CC),
            ),
          ),
        ],
      ),
    );
  }
}
