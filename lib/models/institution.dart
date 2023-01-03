// ignore_for_file: unused_local_variable, unused_import, depend_on_referenced_packages, unnecessary_null_comparison, avoid_print

import 'package:flutter/foundation.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories {
  String id, name;
  List<Categories> subCategories;
  Categories(
      {required this.id, required this.name, required this.subCategories});
  factory Categories.fromMap(Map<String, dynamic> data) {
    final id = data['id'];
    final name = data['name'];
    List<Categories> subCategories1 = [];
    // for (var e in data['subCategories']) {
    //   subCategories1.add(Categories.fromMap(e));
    // }
    final subCategories = subCategories1;
    return Categories(id: id, name: name, subCategories: subCategories);
  }
}

//categories along with subcatgories will be recieved
Future<List<Categories>> getCategories(docName) async {
  List<Categories> categoryList = [];
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("institutions")
        .doc("$docName")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data()!;
      // print("dfds" + data.toString());
      if (data == null) {
        return categoryList;
      } else {
        int index = 0;

        for (var e in snapshot.data()!["categories"]) {
          categoryList.add(Categories.fromMap(e));
          List<Categories> subCat = [];

          for (var e in snapshot.data()!["categories"][index]
              ["subCategories"]) {
            subCat.add(Categories.fromMap(e));
          }
          categoryList[index].subCategories = subCat;
          index++;
        }
        //getting acadamy Name
//snapshot.data()!["name"];
        String acadamyName = "";
        await getAcadamyName().then((value) {
          acadamyName = value;
        });
        if (acadamyName == "noData" || acadamyName == "") {
          setAcadamyName(snapshot.data()!["name"]);
        }
      }
    } else {
      return categoryList;
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }
  return categoryList;
}

Future<String> getAcadamyName() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  // final name = prefs.getStringList('name');
  final String? name = prefs.getString('acadamyName');
  if (name != null) {
    if (name.isNotEmpty) {
      return name;
    } else {
      return "noData";
    }
  } else {
    return "noData";
  }
}

//set name in sp
void setAcadamyName(String a) async {
  String name = a;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('acadamyName', name);
}

//delete name from local storage
void deleteAcadamyName() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('acadamyName');
}
