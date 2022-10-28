import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/screens/onboarding3.dart';
import 'package:smart_acadamy/widgets/onboardingWidget.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);
  static const id = '/onboarding2';
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;

    return OnboardingWidget(
      w: w,
      h: h,
      floatingButtonText: 'ᐳ NEXT',
      boardingImgNo: 2,
      headText: 'Get Instant Results',
      descriptionText:
          'with smart academy you can  write your exams digitaly through mobile app, some content',
      floatOnTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const OnBoarding3()));
      },
    );
  }
}
