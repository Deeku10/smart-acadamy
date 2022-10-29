import 'package:flutter/material.dart';

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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: h * 0.03),
        ),
      ],
    );
  }
}
