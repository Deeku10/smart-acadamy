// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, file_names, duplicate_ignore, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/widgets/resultContainer.dart';
import 'package:provider/provider.dart';
import 'package:smart_acadamy/widgets/smallButton.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);
  static const id = "/resultPage";

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    return pageUI(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Center(child: Icon(Icons.exit_to_app)),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.topToBottom, child: const Home()));
          },
          backgroundColor: Color(0xff4A4A4A),
        ),
        body: Stack(
          children: [
            Container(
              // padding: const EdgeInsets.only(bottom: 100),
              height: h * 0.35,
              width: w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/resultHeader.png"),
                      fit: BoxFit.fill)),
            ),
            Container(
                margin: EdgeInsets.only(top: h * 0.3),
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                height: h * 0.77,
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    ResultContainers(
                      h: h,
                      w: w,
                      containerColor: Color(0xffF5F5F5),
                      text: 'TOTAL',
                      text2: '40',
                      textColor: Colors.black,
                    ),
                    ResultContainers(
                      h: h,
                      w: w,
                      containerColor: Colors.grey,
                      text: 'NOT VIEWED',
                      text2: '17',
                      textColor: Colors.black,
                    ),
                    ResultContainers(
                      h: h,
                      w: w,
                      containerColor: Color(0xff3EC55C),
                      text: 'CORRECT',
                      text2: '23',
                      textColor: Colors.white,
                    ),
                    ResultContainers(
                      h: h,
                      w: w,
                      containerColor: Color.fromARGB(255, 250, 78, 65),
                      text: 'WRONG',
                      text2: '10',
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: h * 0.21,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmallButton(
                            h: h * 1.1,
                            w: w * 1.7,
                            onTap: () {
                              () {};
                            },
                            buttonText: "REATTEMPT",
                            color: Colors.grey),
                        SizedBox(
                          width: w * 0.06,
                        ),
                        SmallButton(
                            h: h * 1.1,
                            w: w * 1.7,
                            onTap: () {
                              () {};
                            },
                            buttonText: "VIEW RESULTS",
                            color: const Color(0xff9700CC)),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
