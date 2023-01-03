// ignore_for_file: unused_import, depend_on_referenced_packages, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/models/institution.dart';
import 'package:smart_acadamy/models/students.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key, required this.studentId}) : super(key: key);
  static const id = "/myAccount";
  final String studentId;
  @override
  State<MyAccount> createState() => _MyAccountState(studentId);
}

class _MyAccountState extends State<MyAccount> {
  String studentId;

  _MyAccountState(this.studentId);

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    // ignore: unused_local_variable
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
        padding: const EdgeInsets.symmetric(horizontal: 25),
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
            FutureBuilder(
              future: getAcadamyName(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                          color: const Color(0xff4D4949),
                          fontWeight: FontWeight.w900,
                          fontSize: h * 0.026),
                    );
                  } else {
                    return Text(
                      "Acadamy",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: h * 0.03),
                    );
                  }
                } else {
                  return Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: Center(
                          child: Container(
                        height: h * 0.02,
                        width: w * 0.75,
                        color: Colors.grey,
                      )));
                }
              },
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
                    backgroundImage:
                        const AssetImage("assets/images/profile.png"),
                  ),
                  FutureBuilder(
                    future: getName(studentId),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return Text(
                            snapshot.data!,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: h * 0.026),
                          );
                        } else {
                          return Text(
                            "Hello",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: h * 0.03),
                          );
                        }
                      } else {
                        return Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: Text(
                              "Aravind Dada",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: h * 0.03),
                            ));
                      }
                    },
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
              floatOnTap: () async {
                deleteName();
                deleteAcadamyName();
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.id, (route) => false);
              },
              h: h * 0.95,
              w: w * 1.5,
              floatingButtonText: 'LOGOUT',
              textColor: Colors.white,
              buttonColor: const Color(0xff9700CC),
            ),
          ],
        ),
      ),
    ]));
  }
}
