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

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart_Acadamy',
      theme: SmartTheme().saTheme,
      initialRoute: OnBoarding1.id,
      routes: {
        OnBoarding1.id: ((context) => const OnBoarding1()),
        OnBoarding2.id: ((context) => const OnBoarding2()),
        OnBoarding3.id: ((context) => const OnBoarding3()),
        Login.id: ((context) => const Login()),
        Home.id: ((context) => const Home()),
        SubCategories.id: ((context) => const SubCategories()),
        PracticePaper.id: ((context) => const PracticePaper()),
        InstructionPage.id: ((context) => const InstructionPage()),
        ExamPage.id: ((context) => ExamPage()),
        ResultPage.id: ((context) => const ResultPage()),
        MyAccount.id: ((context) => const MyAccount()),
        NetworkError.id: ((context) => const NetworkError()),
        Loading.id: ((context) => const Loading()),
      },
    );
  }
}
