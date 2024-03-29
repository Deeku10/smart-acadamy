import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  static const id = '/login';

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(children: [
              Container(
                height: h * 0.83,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: h * 0.17,
                padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'To use Smart Academy, your accademy should be registered in ',
                      style: TextStyle(
                        color: Color(0xff676767),
                        fontSize: (h * 0.02),
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'smartAcademyapp.com',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff676767))),
                        TextSpan(
                            text: ' and create a account for you',
                            style: TextStyle(color: Color(0xff676767))),
                      ],
                    ),
                  ),
                ),
              )
            ]),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: h * 0.15),
                height: h * 0.58,
                width: w * 0.9,
                decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromARGB(255, 189, 187, 187),
                        offset: Offset(
                          0,
                          5.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                      ), //BoxShadow
                    ],
                    border: Border.all(
                        color: const Color.fromARGB(255, 162, 158, 170),
                        width: 0.5,
                        style: BorderStyle.solid),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(h * 0.01)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Text(
                      "Let's sign you in",
                      style: TextStyle(
                          fontSize: h * 0.035,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    Text(
                      'You have been missed',
                      style: TextStyle(
                          fontSize: h * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.07),
                      child: const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your phone',
                          hintText: 'EX:9443322443',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.07),
                      child: Text(
                        'Enter the phone number which you have give in your institute',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: h * 0.019,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.1,
                    ),
                    Button(
                      floatOnTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: const Home()));
                      },
                      h: h,
                      w: w,
                      floatingButtonText: 'LOGIN',
                      textColor: Colors.white,
                      buttonColor: Color(0xff9700CC),
                    ),
                    SizedBox(
                      height: h * 0.045,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Made with ❤️ by ',
                        style: TextStyle(
                          color: Color(0xff676767),
                          fontSize: (h * 0.017),
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Webilicious',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff676767))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
