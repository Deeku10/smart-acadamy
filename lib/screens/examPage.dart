// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:smart_acadamy/models/question.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/resultPage.dart';
// import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/alertDialog.dart';
import 'package:smart_acadamy/widgets/optionContainer.dart';
// import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:smart_acadamy/widgets/smallButton.dart';

class ExamPage extends StatefulWidget {
  ExamPage({Key? key}) : super(key: key);
  static const id = "/examPage";

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int count = 0;
  List answers = [
    ["5/3	", "5/4", "3/5", "4/5"],
    ["3", "4", "5", "6"],
    ["-2/3", "2/3", "3/2", "-3/2"],
    ["1/2", "1", "2", "2/3"],
    ["4/5", "5/4", "2/3", "3/2"],
    ["12", "14", "10", "8"],
    ["-5/3", "-1/13", "-15/3", "-15/13"],
    ["11/7", "7/4", "7/11", "12"]
  ];
  @override
  Widget build(BuildContext context) {
    List questions = [
      "Solve : 7x – 2 = 8 - x",
      "Solve :  2x – 6 = 0",
      "Solve : 8 – 2x = 5 – 4x",
      "Solve : 2(x – 1) + 2(3x -1) = 0",
      "Solve : 4(x-1) –(2x – 5) = 4",
      "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
      "Solve :  (2x+5)/(3x+4)  = 5",
      "3x + 2(x+2) = 10 – (2x – 5)",
    ];
    bool op1 = false, op2 = false, op3 = false, op4 = false;
    var h = context.height;
    var w = context.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff7F63FE),
        elevation: 0,
        actions: [
          Center(
            child: SmallButton(
              h: h,
              w: w,
              buttonText: 'EXIT',
              onTap: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertWidget(
                          h: h,
                          w: w,
                          image: "assets/images/exitImage.png",
                          text: "Are you sure to exit exam?",
                          onTap1: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: const Home()));
                          },
                          onTap2: () {
                            Navigator.pop(context);
                          },
                        ));
              },
              color: Color(0x33FFFFFF),
            ),
          ),
          SizedBox(
            width: w * 0.015,
          ),
          Center(
            child: SmallButton(
              h: h,
              w: w,
              buttonText: 'FINISH',
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const ResultPage()));
              },
              color: const Color(0xff30D787),
            ),
          ),
          SizedBox(
            width: w * 0.05,
          )
        ],
        title: Column(children: [
          Text(
            "Basics",
            style: TextStyle(fontSize: h * 0.022, fontWeight: FontWeight.w900),
          ),
          Text("Algebra",
              style:
                  TextStyle(fontSize: h * 0.018, fontWeight: FontWeight.w600))
        ]),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dy < 0) {
            quetionList(context, h, w);
          }

          // // Swiping in left direction.
          // if (details.delta.dx < 0) {}
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: h * 0.03, horizontal: w * 0.05),
              child: SizedBox(
                width: w,
                child: Text(
                  questions[count],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: h * 0.026),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                op1 = true;
                op2 = false;
                op3 = false;
                op4 = false;
                setState(() {});
              },
              child: OptionContainer(
                h: h,
                answer: answers[count][0],
                w: w,
                tapped: op1,
              ),
            ),
            GestureDetector(
              onTap: () {
                op1 = false;
                op2 = true;
                op3 = false;
                op4 = false;
                setState(() {});
              },
              child: OptionContainer(
                h: h,
                answer: answers[count][1],
                w: w,
                tapped: op2,
              ),
            ),
            GestureDetector(
              onTap: () {
                op1 = false;
                op2 = false;
                op3 = true;
                op4 = false;
                setState(() {});
              },
              child: OptionContainer(
                h: h,
                answer: answers[count][2],
                w: w,
                tapped: op3,
              ),
            ),
            GestureDetector(
              onTap: () {
                op1 = false;
                op2 = false;
                op3 = false;
                op4 = true;
                setState(() {});
              },
              child: OptionContainer(
                h: h,
                answer: answers[count][3],
                w: w,
                tapped: op4,
              ),
            ),
            SizedBox(
              height: h * 0.22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmallButton(
                    h: h * 1.1,
                    w: w * 1.2,
                    onTap: () {
                      if (count != 0) {
                        setState(() {
                          --count;
                        });
                      }
                    },
                    buttonText: "BACK",
                    color: Colors.grey),
                Column(
                  children: [
                    CircleAvatar(
                      radius: h * 0.034,
                      backgroundColor: const Color(0xffF9C954),
                      child: Text(
                        "${count + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        quetionList(context, h, w);
                      },
                      child: Text(
                        "ᐱ",
                        style: TextStyle(
                            fontSize: h * 0.04, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SmallButton(
                    h: h * 1.1,
                    w: w * 1.2,
                    onTap: () {
                      count = count + 1;
                      // if (count != questions.length - 1) {
                      setState(() {});
                      // }
                    },
                    buttonText: "NEXT",
                    color: Color(0xff9700CC)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> quetionList(BuildContext context, double h, double w) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.black,
              maxRadius: h * 0.04,
              child: Icon(Icons.close),
            ),
          ),
          body: Wrap(
            // direction: Axis.vertical,
            children: [
              Container(
                height: h,
                width: w,
                child: Stack(
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(bottom: 100),
                      height: h * 0.35,
                      width: w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/allQuestions.png"),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: h * 0.3),
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.06, vertical: h * 0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      height: h * 0.7,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: h * 0.065),
                            child: ListView(
                              // padding: EdgeInsets.symmetric(
                              //     vertical: h * 0.04),
                              physics: BouncingScrollPhysics(),
                              children: [
                                // SizedBox(
                                //   height: h * 0.035,
                                // ),
                                GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 15.0,
                                  ),
                                  itemCount: 60,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h * 0.07125,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: h * 0.017),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: h * 0.04,
                            width: w,
                            margin: EdgeInsets.symmetric(vertical: h * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: h * 0.8,
                                ),
                                Container(
                                  height: h * 0.023,
                                  width: h * 0.023,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: w * 0.013,
                                ),
                                Text(
                                  "Not Viewed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.015),
                                ),
                                SizedBox(
                                  width: w * 0.03,
                                ),
                                Container(
                                  height: h * 0.023,
                                  width: h * 0.023,
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: w * 0.013,
                                ),
                                Text(
                                  "Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.015),
                                ),
                                SizedBox(
                                  width: w * 0.03,
                                ),
                                Container(
                                  height: h * 0.023,
                                  width: h * 0.023,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: w * 0.013,
                                ),
                                Text(
                                  "Not Answered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.015),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
