import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_acadamy/heightWidth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_acadamy/models/categoriesGrid.dart';
import 'package:smart_acadamy/screens/myAccount.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:smart_acadamy/widgets/alertDialog.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const id = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _pages = <Widget>[
    HomePage(),
    MyAccount(),
  ];
  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;

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
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: h * 0.018,

            selectedItemColor: Colors.black,
            backgroundColor: Color(0xffF9C954),

            currentIndex: _selectedIndex, //New
            onTap: (index) => setState(() => _selectedIndex = index),
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
          body: _pages[_selectedIndex]),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  List<CategorieGrid> cg = [
    CategorieGrid("Maths", "123/200"),
    CategorieGrid("Physics", "123/200"),
    CategorieGrid("Chemistry", "123/200"),
    CategorieGrid("Biology", "123/200"),
    CategorieGrid("Computers", "123/200"),
    CategorieGrid("General Knowledge", "123/200"),
    CategorieGrid("English", "123/200"),
  ];

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
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: const SubCategories()));
              },
              text: "Categories",
              cg: cg,
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
                      AssetImage("assets/images/homeTopCircle.png"),
                  child: Text(
                    "12",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: h * 0.021),
                  ),
                  radius: w * 0.09,
                ),
                Text(
                  "114/500",
                  style: TextStyle(
                      color: Color(0xff725902),
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
                color: Color(0xd9ffffff),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                SizedBox(
                  width: w * 0.07,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
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
                        style: TextStyle(
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
                      style: TextStyle(
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
