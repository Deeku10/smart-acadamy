// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/screens/onboarding2.dart';
import 'package:smart_acadamy/widgets/onboardingWidget.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);
  static const id = '/onboarding1';
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;

    return OnboardingWidget(
      w: w,
      h: h,
      floatingButtonText: 'ᐳ NEXT',
      boardingImgNo: 1,
      headText: 'Write Exams Digitaly',
      descriptionText:
          'with smart academy you can  write your exams digitaly through mobile app, some content',
      floatOnTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const OnBoarding2()));
        // Navigator.pushNamed(context, OnBoarding2.id);
      },
    );
  }
}
