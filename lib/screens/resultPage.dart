// ignore: file_names
import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/widgets/resultContainer.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);
  static const id = "/resultPage";
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    return Scaffold(
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
                ],
              )),
        ],
      ),
    );
  }
}
