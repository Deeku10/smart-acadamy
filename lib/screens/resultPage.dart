// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, file_names, duplicate_ignore, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/questions.dart';
import 'package:smart_acadamy/models/result.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/instructionPage.dart';
import 'package:smart_acadamy/screens/loading.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/resultView.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:smart_acadamy/widgets/resultContainer.dart';
import 'package:smart_acadamy/widgets/smallButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
    required this.answers,
    required this.questions,
    required this.qid,
    required this.subCategories,
    required this.categories,
  }) : super(key: key);
  static const id = "/resultPage";
  final List answers;
  final List<Question> questions;
  final String qid;
  final String subCategories;
  final String categories;

  @override
  // ignore: no_logic_in_create_state
  State<ResultPage> createState() =>
      _ResultPageState(answers, questions, qid, subCategories, categories);
}

class _ResultPageState extends State<ResultPage> {
  final List answers;
  final List<Question> questions;
  final String qid;
  final String subCategories;
  final String categories;
  _ResultPageState(this.answers, this.questions, this.qid, this.subCategories,
      this.categories);
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    int indexFromProvider = Provider.of<QuestionIndexProvider>(context).index;
    var auth = FirebaseAuth.instance.currentUser;
    var h = context.height;
    var w = context.width;
    return pageUI(
      FutureBuilder(
        future: submitExam(qid, answers, auth!.uid),
        builder: (context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Center(child: Icon(Icons.exit_to_app)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) {
                      return const Home();
                    }), (route) => false);
                  },
                  backgroundColor: Color(0xff4A4A4A),
                ),
                body: Stack(
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(bottom: 100),
                      height: h * 0.35,
                      width: w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/resultHeader.png"),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: h * 0.3),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        height: h * 0.77,
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.05,
                            ),
                            ResultContainers(
                              h: h,
                              w: w,
                              containerColor: Color(0xffF5F5F5),
                              text: 'TOTAL',
                              text2: snapshot.data!.total.toString(),
                              textColor: Colors.black,
                            ),
                            ResultContainers(
                              h: h,
                              w: w,
                              containerColor: Colors.grey,
                              text: 'NOT VIEWED',
                              text2: snapshot.data!.notAnswered.toString(),
                              textColor: Colors.black,
                            ),
                            ResultContainers(
                              h: h,
                              w: w,
                              containerColor: Color(0xff3EC55C),
                              text: 'CORRECT',
                              text2: snapshot.data!.correct.toString(),
                              textColor: Colors.white,
                            ),
                            ResultContainers(
                              h: h,
                              w: w,
                              containerColor: Color.fromARGB(255, 250, 78, 65),
                              text: 'WRONG',
                              text2: snapshot.data!.wrong.toString(),
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              height: h * 0.21,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: w * 0.03,
                                ),
                                SmallButton(
                                    h: h * 1,
                                    w: w * 1.6,
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("attempts")
                                          .doc("${auth.uid}_$qid")
                                          .delete()
                                          .then((value) {
                                        clearAnswer();
                                        Provider.of<QuestionIndexProvider>(
                                                context,
                                                listen: false)
                                            .changeIndex(0);
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute<dynamic>(builder:
                                                (BuildContext context) {
                                          return InstructionPage(
                                              categories: categories,
                                              subCategories: subCategories,
                                              qid: qid);
                                        }), (route) => false);
                                      });
                                    },
                                    buttonText: "REATTEMPT",
                                    color: Colors.grey),
                                SizedBox(
                                  width: w * 0.04,
                                ),
                                SmallButton(
                                    h: h * 1,
                                    w: w * 1.6,
                                    onTap: () {
                                      Provider.of<QuestionIndexProvider>(
                                              context,
                                              listen: false)
                                          .changeIndex(0);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .leftToRight,
                                              child: ResultView(
                                                pquestions: questions,
                                                result: snapshot.data!.result,
                                              )));
                                    },
                                    buttonText: "VIEW RESULTS",
                                    color: const Color(0xff9700CC)),
                                SizedBox(
                                  width: w * 0.015,
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Scaffold(body: Loading());
          }
        },
      ),
    );
  }
}
