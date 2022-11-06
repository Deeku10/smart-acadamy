// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:smart_acadamy/screens/subcategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      }
    } else {
      return categoryList;
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }
  return categoryList;
}
