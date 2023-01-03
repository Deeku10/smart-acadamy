// ignore_for_file: unnecessary_import, depend_on_referenced_packages, prefer_const_constructors

import 'dart:ui';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'package:smart_acadamy/heightWidth.dart';

import 'package:smart_acadamy/models/institution.dart';
import 'package:smart_acadamy/screens/instructionPage.dart';
import 'package:smart_acadamy/screens/networkError.dart';
import 'package:smart_acadamy/screens/practicePaper.dart';
import 'package:smart_acadamy/widgets/search_with_cards.dart';
import 'package:provider/provider.dart';

class SubCategories extends StatefulWidget {
  const SubCategories(
      {Key? key, required this.categoryName, required this.subCategories})
      : super(key: key);
  static const id = "/subCat";
  final String categoryName;
  final List<Categories> subCategories;
  @override
  // ignore: no_logic_in_create_state
  State<SubCategories> createState() =>
      _SubCategoriesState(categoryName, subCategories);
}

class _SubCategoriesState extends State<SubCategories> {
  final String categoryName;

  final List<Categories> subCategories;

  _SubCategoriesState(this.categoryName, this.subCategories);

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
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                      fontSize: h * 0.022,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1),
                ),
                // Text("123/200",
                //     style: TextStyle(
                //         letterSpacing: 1.1,
                //         fontSize: h * 0.017,
                //         fontWeight: FontWeight.w900))
              ],
            ),
            backgroundColor: const Color(0xff7F63FE),
          ),
          body: Search_with_cards(
            labelText: 'Search in SubCategories',
            h: h,
            w: w,
            text: "Sub Categories",
            catWidget: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    childAspectRatio: 1.8,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 20),
                padding: EdgeInsets.all(h * 0.01),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: subCategories.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.topToBottom,
                              child: InstructionPage(
                                categories: categoryName,
                                qid: subCategories[index].id,
                                subCategories: subCategories[index].name,
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: w * 0.03),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                      width: w,
                      decoration: BoxDecoration(
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(172, 158, 158, 158),
                                spreadRadius: 0.3,
                                blurRadius: 5,
                                offset: Offset(3, 2)),
                          ],
                          color: const Color(0xffC377FF),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: w,
                          ),
                          FittedBox(
                            // width: w * 0.2,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            child: Text(
                              subCategories[index].name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //version 2
                          // Text(cg[index].subText,
                          //     style: TextStyle(
                          //         fontSize: h * 0.015,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white))
                        ],
                      ),
                    ),
                  );
                }),
          )),
    );
  }
}
// class subjContainers{
//   subjContainers()
// }