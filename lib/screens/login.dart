import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/widgets/button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:pinput/pinput.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const id = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone = "";
  String oTP = "";
  bool loading = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          phone = value;
                        },
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
                      floatOnTap: () async {
                        if (phone.length != 10) {
                          final snackBar = SnackBar(
                            content: Text("Enter a proper mobile number"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          loading == true
                              ? showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                      // title: const Text("Loading"),

                                      content: ImageAndText(
                                    h: h * 0.7,
                                    assetImage: "assets/images/loading.png",
                                    descriptionText: "Loading...",
                                  )),
                                )
                              : () {};
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91 ${phone}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              // loading = false;
                              // setState(() {});
                              Navigator.pop(context);
                              final snackBar = SnackBar(
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            codeSent: (String verificationId,
                                int? resendToken) async {
                              // loading = false;
                              // setState(() {});
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  //title: const Text("Alert Dialog Box"),

                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Enter Otp",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: h * 0.025,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Pinput(
                                        length: 6,
                                        pinputAutovalidateMode:
                                            PinputAutovalidateMode.onSubmit,
                                        showCursor: true,
                                        onCompleted: (value) {
                                          oTP = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: h * 0.03,
                                      ),
                                      Button(
                                          floatOnTap: () async {
                                            try {
                                              // Create a PhoneAuthCredential with the code
                                              PhoneAuthCredential credential =
                                                  PhoneAuthProvider.credential(
                                                      verificationId:
                                                          verificationId,
                                                      smsCode: oTP);

                                              // Sign the user in (or link) with the credential
                                              await auth.signInWithCredential(
                                                  credential);
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Home.id,
                                                  (route) => false);
                                            } catch (e) {
                                              final snackBar = SnackBar(
                                                content: Text(e.toString()),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          w: w,
                                          h: h,
                                          floatingButtonText: "Confirm OTP",
                                          buttonColor: Color(0xff9700CC),
                                          textColor: Colors.white),
                                      TextButton(
                                          onPressed: () async {},
                                          child: Text(
                                            "RESEND OTP",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              setState(() {
                                loading = false;
                              });
                            },
                          );
                        }
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
