// ignore_for_file: file_names
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    Key? key,
    required this.w,
    required this.h,
    required this.floatingButtonText,
    required this.boardingImgNo,
    required this.headText,
    required this.descriptionText,
    required this.floatOnTap,
  }) : super(key: key);

  final double w;
  final double h;
  final String floatingButtonText;
  final int boardingImgNo;
  final String headText;
  final String descriptionText;
  final Function floatOnTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          floatOnTap();
        },
        child: Container(
          // height: h * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(0xffE8DEF8),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.08, vertical: h * 0.014),
          child: Text(
            floatingButtonText,
            style: TextStyle(
                color: const Color(0xff1D192B),
                letterSpacing: h * 0.002,
                fontSize: h * 0.023,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/onboarding${boardingImgNo.toString()}.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: w,
              ),
              Text(
                headText,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.027,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: h * 0.17,
              )
              // TextButton(onPressed: () {}, child: Text('ᐳ Next'))
            ],
          )
        ],
      ),
    );
  }
}
