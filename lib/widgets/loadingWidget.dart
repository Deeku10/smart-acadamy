// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_acadamy/widgets/button.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.h,
    required this.assetImage,
    required this.descriptionText,
  }) : super(key: key);

  final double h;
  final String assetImage, descriptionText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ImageAndText(
          h: h, assetImage: assetImage, descriptionText: descriptionText),
    ));
  }
}

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    Key? key,
    required this.h,
    required this.assetImage,
    required this.descriptionText,
  }) : super(key: key);

  final double h;
  final String assetImage;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: h * 0.35,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(assetImage))),
        ),
        Text(
          descriptionText,
          maxLines: 4,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: h * 0.03),
        ),
      ],
    );
  }
}

class LoadingWidgetWithButton extends StatelessWidget {
  const LoadingWidgetWithButton({
    Key? key,
    required this.h,
    required this.assetImage,
    required this.descriptionText,
    required this.onTap,
    required this.w,
    required this.buttonText,
  }) : super(key: key);

  final double h, w;
  final String assetImage, descriptionText, buttonText;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ImageAndText(
              h: h, assetImage: assetImage, descriptionText: descriptionText),
        ),
        Button(
          buttonColor: Color(0xff9700CC),
          floatOnTap: () {
            onTap();
          },
          floatingButtonText: buttonText,
          h: h,
          textColor: Colors.white,
          w: w,
        ),
      ],
    ));
  }
}
