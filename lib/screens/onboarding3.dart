// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:smart_acadamy/widgets/onboardingWidget.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);
  static const id = '/onboarding3';
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;

    return OnboardingWidget(
      w: w,
      h: h,
      floatingButtonText: 'ᐳ NEXT',
      boardingImgNo: 3,
      headText: 'Analyse your marks',
      descriptionText:
          'with smart academy you can  write your exams digitaly through mobile app, some content',
      floatOnTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom, child: const Login()));
      },
    );
  }
}
