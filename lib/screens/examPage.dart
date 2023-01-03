// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors_in_immutables, file_names, no_logic_in_create_state, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/models/questions.dart';
// import 'package:smart_acadamy/models/question.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/loading.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/resultPage.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
// import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/alertDialog.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:smart_acadamy/widgets/optionContainer.dart';
// import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:smart_acadamy/widgets/smallButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class ExamPage extends StatefulWidget {
  final String subCategories;
  final String qid;
  final String categories;

  ExamPage(
      {Key? key,
      required this.subCategories,
      required this.categories,
      required this.qid})
      : super(key: key);
  static const id = "/examPage";

  @override
  State<ExamPage> createState() =>
      _ExamPageState(categories, qid, subCategories);
}

class _ExamPageState extends State<ExamPage> {
  String categories;
  String qid;
  String subCategories;

  _ExamPageState(this.categories, this.qid, this.subCategories);

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    int indexFromProvider = Provider.of<QuestionIndexProvider>(context).index;
    bool op1 = false, op2 = false, op3 = false, op4 = false;
    var h = context.height;
    var w = context.width;
    print("$indexFromProvider is the index from provider");
    return pageUI(
      FutureBuilder(
        future: getQuestion(qid),
        builder: (context, AsyncSnapshot<List<Question>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data!.length != 0) {
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xff7F63FE),
                    elevation: 0,
                    actions: [
                      Center(
                        child: SmallButton(
                          h: h * 0.95,
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
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute<dynamic>(builder:
                                                (BuildContext context) {
                                          return const Home();
                                        }), (route) => false);
                                        // Navigator.push(
                                        //     context,
                                        //     PageTransition(
                                        //         type: PageTransitionType
                                        //             .leftToRight,
                                        //         child: const Home()));
                                      },
                                      onTap2: () {
                                        Navigator.pop(context);
                                      },
                                    ));
                          },
                          color: const Color(0x33FFFFFF),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.015,
                      ),
                      Center(
                        child: SmallButton(
                          h: h * 0.95,
                          w: w,
                          buttonText: 'FINISH',
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) {
                              return ResultPage(
                                answers: answer,
                                qid: qid,
                                questions: snapshot.data!,
                                categories: categories,
                                subCategories: subCategories,
                              );
                            }), (route) => false).then((value) {
                              clearAnswer();
                              Provider.of<QuestionIndexProvider>(context,
                                      listen: false)
                                  .changeIndex(0);
                            });

                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         type: PageTransitionType.leftToRight,
                            //         child: ResultPage(
                            //           answers: answer,
                            //           qid: qid,
                            //           questions: snapshot.data!,
                            //         )));
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
                        categories,
                        style: TextStyle(
                            fontSize: h * 0.022, fontWeight: FontWeight.w900),
                      ),
                      Text(subCategories,
                          style: TextStyle(
                              fontSize: h * 0.018, fontWeight: FontWeight.w600))
                    ]),
                  ),
                  body: GestureDetector(
                    onPanUpdate: (details) {
                      // Swiping in right direction.
                      if (details.delta.dy < 0) {
                        quetionList(context, h, w, snapshot.data!, answer);
                      }
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
                              snapshot.data![indexFromProvider].question,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.026),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot
                                  .data![indexFromProvider].options.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: GestureDetector(
                                    // onTap: () {
                                    //   print(snapshot
                                    //       .data![indexFromProvider].answers);
                                    //   if (snapshot
                                    //       .data![indexFromProvider].answers
                                    //       .contains(-1)) {
                                    //     snapshot.data![indexFromProvider].answers
                                    //         .remove(-1);
                                    //     snapshot.data![indexFromProvider].answers
                                    //         .add(index);
                                    //   } else if (snapshot
                                    //       .data![indexFromProvider].answers
                                    //       .contains(index)) {
                                    //     snapshot.data![indexFromProvider].answers
                                    //         .clear();
                                    //     snapshot.data![indexFromProvider].answers
                                    //         .add(index);
                                    //   } else {
                                    //     //do nothing
                                    //   }
                                    //   print(snapshot
                                    //       .data![indexFromProvider].answers);
                                    //   setState(() {});
                                    // },
                                    onTap: (() {
                                      print(answer);
                                      if (answer[indexFromProvider] == -1) {
                                        answer[indexFromProvider] = index;
                                      } else if (answer[indexFromProvider] ==
                                          index) {
                                        answer[indexFromProvider] = -1;
                                      } else if (answer[indexFromProvider] !=
                                          index) {
                                        // answer[indexFromProvider] = -1;
                                        answer[indexFromProvider] = index;
                                      } else {
                                        //do nothing
                                      }
                                      print(answer);
                                      setState(() {});
                                    }),
                                    // child: OptionContainer(
                                    //   h: h,
                                    //   answer:  snapshot.data![indexFromProvider].options[index],
                                    //   w: w,
                                    //   tapped:  snapshot.data![indexFromProvider].answers.contains(index),
                                    // ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: h * 0.01,
                                          horizontal: w * 0.03),
                                      padding: EdgeInsets.symmetric(
                                          vertical: h * 0.021,
                                          horizontal: w * 0.04),
                                      height: h * 0.07,
                                      width: w * 0.9,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data![indexFromProvider]
                                              .options[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: h * 0.025,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              answer[indexFromProvider] == index
                                                  ? Colors.green
                                                  : const Color(0xfff5f5f5)),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SmallButton(
                                h: h,
                                w: w * 1.1,
                                onTap: () {
                                  if (indexFromProvider != 0) {
                                    Provider.of<QuestionIndexProvider>(context,
                                            listen: false)
                                        .changeIndex(indexFromProvider - 1);
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
                                    "${indexFromProvider + 1}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    quetionList(
                                        context, h, w, snapshot.data!, answer);
                                  },
                                  child: Text(
                                    "ᐱ",
                                    style: TextStyle(
                                        fontSize: h * 0.04,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SmallButton(
                                h: h * 1,
                                w: w * 1.1,
                                onTap: () {
                                  if (indexFromProvider <
                                      snapshot.data!.length - 1) {
                                    Provider.of<QuestionIndexProvider>(context,
                                            listen: false)
                                        .changeIndex(indexFromProvider + 1);
                                  }
                                },
                                buttonText: "NEXT",
                                color: const Color(0xff9700CC)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                    body: LoadingWidgetWithButton(
                  assetImage: 'assets/images/expired.png',
                  descriptionText: "The test Papers will be uploaded soon! :)",
                  buttonText: 'Go to Home',
                  h: h,
                  w: w,
                  onTap: () async {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Home.id, (route) => false);
                  },
                ));
              }
            } else {
              return Container();
            }
          } else {
            return Scaffold(body: Loading());
          }
        },
      ),

      //
      //
      //
    );
  }

  Future<dynamic> quetionList(BuildContext context, double h, double w,
      List<Question> questions, List<int> answer) {
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
              child: const Icon(Icons.close),
            ),
          ),
          body: Wrap(
            // direction: Axis.vertical,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: h,
                width: w,
                child: Stack(
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(bottom: 100),
                      height: h * 0.35,
                      width: w,
                      decoration: const BoxDecoration(
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
                              physics: const BouncingScrollPhysics(),
                              children: [
                                // SizedBox(
                                //   height: h * 0.035,
                                // ),
                                GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 15.0,
                                  ),
                                  itemCount: questions.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Provider.of<QuestionIndexProvider>(
                                                context,
                                                listen: false)
                                            .changeIndex(index);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: h * 0.07125,
                                        decoration: BoxDecoration(
                                          color: answer[index] == -1
                                              ? Color.fromARGB(
                                                  255, 198, 198, 198)
                                              : Color.fromARGB(
                                                  255, 57, 231, 147),
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
                                  decoration: const BoxDecoration(
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
                                  decoration: const BoxDecoration(
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
                                  decoration: const BoxDecoration(
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
