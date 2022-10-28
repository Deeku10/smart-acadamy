import 'package:flutter/material.dart';
import 'package:smart_acadamy/widgets/smallButton.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.image,
    required this.text,
    required this.onTap1,
    required this.onTap2,
  }) : super(key: key);

  final double h;
  final double w;
  final String image, text;
  final Function onTap1, onTap2;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // insetPadding: EdgeInsets.al,
      // title: const
      // shape: const ShapeBorder(),
      content: Container(
        // padding: EdgeInsets.symmetric(vertical: h * 0.05),
        height: h * 0.30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.25,
              width: w * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image))),
            ),
            Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: h * 0.023),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: h * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallButton(
                  h: h * 1.1,
                  w: w * 1.2,
                  onTap: () {
                    onTap1();
                  },
                  buttonText: "Yes,I am",
                  color: Colors.grey),
              SmallButton(
                  h: h * 1.1,
                  w: w * 1.2,
                  onTap: () {
                    onTap2();
                  },
                  buttonText: "No",
                  color: Color(0xff9700CC)),
            ],
          ),
        )
      ],
    );
  }
}
