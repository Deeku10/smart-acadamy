// ignore_for_file: file_names, unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/institution.dart';
import 'package:smart_acadamy/models/questions.dart';
import 'package:smart_acadamy/models/result.dart';
import 'package:smart_acadamy/screens/examPage.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/loading.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/resultPage.dart';
import 'package:smart_acadamy/screens/resultView.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InstructionPage extends StatefulWidget {
  final String categories;
  final String qid;
  final String subCategories;
  const InstructionPage({
    Key? key,
    required this.categories,
    required this.subCategories,
    required this.qid,
  }) : super(key: key);
  static const id = "/instructionPage";

  @override
  State<InstructionPage> createState() =>
      _InstructionPageState(categories, qid, subCategories);
}

class _InstructionPageState extends State<InstructionPage> {
  String categories;
  String qid;
  String subCategories;

  _InstructionPageState(this.categories, this.qid, this.subCategories);
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance.currentUser;

    var h = context.height;
    var w = context.width;
    return pageUI(
      FutureBuilder(
        future: getAnswers("${auth!.uid}_$qid"),
        builder: (context, AsyncSnapshot<List> snapshotAnswer) {
          if (snapshotAnswer.hasData) {
            if (snapshotAnswer.data!.length != 0) {
              print("it is null" + snapshotAnswer.data!.toString());
              return FutureBuilder(
                future: getQuestion(qid),
                builder:
                    (context, AsyncSnapshot<List<Question>> snapshotQustion) {
                  if (snapshotQustion.hasData) {
                    if (snapshotQustion.data != null) {
                      if (snapshotQustion.data!.length != 0) {
                        return ResultPage(
                          categories: categories,
                          subCategories: subCategories,
                          answers: snapshotAnswer.data!,
                          qid: qid,
                          questions: snapshotQustion.data!,
                        );
                      } else {
                        return Scaffold(
                            body: LoadingWidgetWithButton(
                          assetImage: 'assets/images/expired.png',
                          descriptionText:
                              "The test Papers will be uploaded soon! :)",
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
                    return Scaffold(
                      body: Loading(),
                    );
                  }
                },
              );
            } else {
              return Scaffold(
                body: Stack(
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(bottom: 100),
                      height: h * 0.35,
                      width: w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/instructionHeader.png"),
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
                          itemCount: instructions.length,
                          itemBuilder: ((context, index) => Text(
                                "${index + 1}. ${instructions[index]}",
                                style: TextStyle(
                                    fontSize: h * 0.017,
                                    fontWeight: FontWeight.w600),
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
                                  child: ExamPage(
                                    categories: categories,
                                    qid: qid,
                                    subCategories: subCategories,
                                  )));
                        },
                        h: h * 0.95,
                        w: w,
                        floatingButtonText: 'I understood,start the exam',
                        textColor: Colors.white,
                        buttonColor: const Color(0xff9700CC),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Scaffold(
              body: Loading(),
            );
          }
        },
      ),
    );
  }
}

List<String> instructions = [
  "This test consist of 20 Questions.",
  "This test consists only BASICS OF MATHEMATICS questions.",
  "The maximum marks for test is 20 marks.",
  "Each question is alloted for ONE mark for correct answer.",
  "Out of four options given for each question,only one option is the correct answer.",
  "There is no time limit for the exam.",
  "There is no limitation for re attempting the test.",
  "There is no negative marking .",
];
