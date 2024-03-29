import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:page_transition/page_transition.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);
  static const id = "/myAccount";
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    int _selectedIndex = 1;

    return Scaffold(
        body: Stack(children: [
      Container(
        // padding: const EdgeInsets.only(bottom: 100),
        height: h * 0.35,
        width: w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/myAccountHeader.png"),
                fit: BoxFit.fill)),
      ),
      Container(
        margin: EdgeInsets.only(top: h * 0.3),
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        height: h * 0.77,
        child: Column(
          children: [
            SizedBox(
              width: w,
              height: h * 0.05,
            ),
            Text(
              "Master JEE Acadamy",
              style: TextStyle(
                  color: Color(0xff4D4949),
                  fontWeight: FontWeight.w900,
                  fontSize: h * 0.026),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.054),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 6,
                  blurRadius: 15,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              height: h * 0.31,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w * 0.892,
                  ),
                  CircleAvatar(
                    radius: h * 0.07,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  Text(
                    "Aravind Dada",
                    style: TextStyle(
                        fontWeight: FontWeight.w900, fontSize: h * 0.03),
                  ),
                  Text(
                    "Valid till: 23/07/2022",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: h * 0.017,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            Button(
              floatOnTap: () {
                // logout system
                Navigator.popAndPushNamed(context, Login.id);
              },
              h: h,
              w: w,
              floatingButtonText: 'LOGOUT',
              textColor: Colors.white,
              buttonColor: Color(0xff9700CC),
            ),
          ],
        ),
      ),
    ]));
  }
}
