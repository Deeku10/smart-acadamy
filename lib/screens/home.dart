import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/services.dart';
import 'package:smart_acadamy/heightWidth.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';
import 'package:smart_acadamy/models/institution.dart';
import 'package:smart_acadamy/models/students.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_acadamy/screens/myAccount.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/alertDialog.dart';
import 'package:smart_acadamy/widgets/loadingWidget.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String institutionId;
  int _selectedIndex = 0;
  // final List<Widget> _pacges = <Widget>[
  //   HomePage(institutionId: ,),
  //   MyAccount(),
  // ];
  // AppUpdateInfo? _updateInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     info.updateAvailability == UpdateAvailability.updateAvailable
  //         ? () {
  //             InAppUpdate.performImmediateUpdate()
  //                 // ignore: invalid_return_type_for_catch_error
  //                 .catchError((e) => showSnack(e.toString()));
  //           }
  //         : () {};
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }

  // void showSnack(String text) {
  //   if (_scaffoldKey.currentContext != null) {
  //     ScaffoldMessenger.of(_scaffoldKey.currentContext!)
  //         .showSnackBar(SnackBar(content: Text(text)));
  //   }
  // }

  // @override
  // // ignore: must_call_super
  // initState() {
  //   checkForUpdate();
  // }
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance.currentUser;
    var h = context.height;
    var w = context.width;
    return pageUI(
      FutureBuilder(
        future: getStudent(auth?.uid),
        builder: (context, AsyncSnapshot<Student?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data!.status == "active") {
                return WillPopScope(
                  onWillPop: () async {
                    return await showDialog(
                        context: context,
                        builder: (context) => AlertWidget(
                            h: h,
                            w: w,
                            image: "assets/images/Schoolbus.png",
                            text: "Are you sure to exit?",
                            onTap1: () {
                              SystemNavigator.pop();
                            },
                            onTap2: () {
                              Navigator.pop(context);
                            }));
                  },
                  child: Scaffold(
                      key: _scaffoldKey,
                      resizeToAvoidBottomInset: false,
                      bottomNavigationBar: BottomNavigationBar(
                        selectedFontSize: h * 0.018,

                        selectedItemColor: Colors.black,
                        backgroundColor: const Color(0xffF9C954),

                        currentIndex: _selectedIndex, //New
                        onTap: (index) =>
                            setState(() => _selectedIndex = index),
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_filled),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: 'Account',
                          ),
                        ],
                      ),
                      body: <Widget>[
                        HomePage(
                          institutionId: snapshot.data!.institutionId,
                        ),
                        MyAccount(),
                      ][_selectedIndex]),
                );
              } else if (snapshot.data!.status == "expired") {
                return LoadingWidgetWithButton(
                  assetImage: 'assets/images/expired.png',
                  buttonText: 'Logout',
                  h: h,
                  w: w,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Login.id, (route) => false);
                  },
                  descriptionText:
                      'Your network have been expired.\nkindly contact your institute',
                );
              } else {
                return LoadingWidgetWithButton(
                  assetImage: 'assets/images/nonumber.png',
                  buttonText: 'Logout',
                  h: h,
                  w: w,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Login.id, (route) => false);
                  },
                  descriptionText:
                      'The phone number \n is not linked with any institute',
                );
              }
            } else {
              return NetworkError();
            }
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: w),
                  // ignore: prefer_const_constructors
                  CircularProgressIndicator(
                    color: Colors.purpleAccent,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );

    // return pageUI();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.institutionId}) : super(key: key);
  final String institutionId;
  @override
  State<HomePage> createState() => _HomePageState(institutionId);
}

class _HomePageState extends State<HomePage> {
  final String institutionId;

  _HomePageState(this.institutionId);

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding:fasle;
      body: Stack(
        children: [
          Container(
            // padding: const EdgeInsets.only(bottom: 100),
            height: h * 0.33,
            width: w,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/categoriesHeader.png"),
                    fit: BoxFit.fill)),
          ),
          Container(
            margin: EdgeInsets.only(top: h * 0.3),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            height: h * 0.77,
          ),
          Container(
            margin: EdgeInsets.only(top: h * 0.33),
            height: h * 0.77,
            child: Search_with_cards(
              h: h,
              w: w,
              text: "Categories",
              catWidget: FutureBuilder(
                future: getCategories(institutionId),
                builder: (context, AsyncSnapshot<List<Categories>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      if (snapshot.data!.length != 0) {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 220,
                                    childAspectRatio: 1.8,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 20),
                            padding: EdgeInsets.all(h * 0.01),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftWithFade,
                                          child: SubCategories(
                                            categoryName:
                                                snapshot.data![index].name,
                                            subCategories: snapshot
                                                .data![index].subCategories,
                                          )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: w * 0.03),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.07),
                                  width: w,
                                  decoration: BoxDecoration(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                172, 158, 158, 158),
                                            spreadRadius: 0.3,
                                            blurRadius: 5,
                                            offset: Offset(3, 2)),
                                      ],
                                      color: const Color(0xffC377FF),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: w,
                                      ),
                                      FittedBox(
                                        // width: w * 0.2,
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // Text(cg[index].subText,
                                      //     style: TextStyle(
                                      //         fontSize: h * 0.015,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.white)
                                      //         )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Container(
                          child: Center(
                              child:
                                  Text("Wait for the classes to be uploaded")),
                        );
                      }
                    } else {
                      return Container();
                    }
                  } else {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: w),
                          // ignore: prefer_const_constructors
                          CircularProgressIndicator(
                            color: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: w * 0.39, bottom: h * 0.3257),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/crown.png",
                  height: h * 0.045,
                ),
                CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/homeTopCircle.png"),
                  radius: w * 0.09,
                  child: Text(
                    "12",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: h * 0.021),
                  ),
                ),
                Text(
                  "114/500",
                  style: TextStyle(
                      color: const Color(0xff725902),
                      fontSize: h * 0.025,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w900),
                ),
                // SizedBox(
                //   height: h * 0.33,
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: w * 0.05, top: h * 0.1),
            height: h * 0.1,
            width: w * 0.8,
            decoration: BoxDecoration(
                color: const Color(0xd9ffffff),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                SizedBox(
                  width: w * 0.07,
                ),
                CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/images/profile.png"),
                  backgroundColor: Colors.black,
                  radius: h * 0.032,
                ),
                SizedBox(
                  width: w * 0.06,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Hello ',
                              style: TextStyle(fontSize: h * 0.026)),
                          TextSpan(
                              text: 'Aravind !',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.026)),
                        ],
                      ),
                    ),
                    // Text(
                    //   "Hello Aravind !",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, fontSize: h * 0.026),
                    // ),
                    Text(
                      "Good ${greeting()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
