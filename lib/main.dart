// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_acadamy/screens/examPage.dart';
import 'package:smart_acadamy/screens/home.dart';
import 'package:smart_acadamy/screens/instructionPage.dart';
import 'package:smart_acadamy/screens/loading.dart';
import 'package:smart_acadamy/screens/login.dart';
import 'package:smart_acadamy/screens/myAccount.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/onboarding1.dart';
import 'package:smart_acadamy/screens/onboarding2.dart';
import 'package:smart_acadamy/screens/onboarding3.dart';
import 'package:smart_acadamy/screens/practicePaper.dart';
import 'package:smart_acadamy/screens/resultPage.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ConnectivityProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart_Acadamy',
        theme: SmartTheme().saTheme,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? OnBoarding1.id
            : Home.id,
        //initialRoute: OnBoarding1.id,
        routes: {
          OnBoarding1.id: ((context) => const OnBoarding1()),
          OnBoarding2.id: ((context) => const OnBoarding2()),
          OnBoarding3.id: ((context) => const OnBoarding3()),
          Login.id: ((context) => const Login()),
          Home.id: ((context) => const Home()),
          // ignore: prefer_const_constructors
          SubCategories.id: ((context) => SubCategories(
                categoryName: '',
                subCategories: [],
              )),
          PracticePaper.id: ((context) => const PracticePaper()),
          InstructionPage.id: ((context) => const InstructionPage()),
          ExamPage.id: ((context) => ExamPage()),
          ResultPage.id: ((context) => const ResultPage()),
          MyAccount.id: ((context) => const MyAccount()),
          NetworkError.id: ((context) => const NetworkError()),
          Loading.id: ((context) => const Loading()),
        },
      ),
    );
  }
}
