// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_print, await_only_futures

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  String institutionId, status;
  Student({
    required this.institutionId,
    required this.status,
  });
//   final prefs = await SharedPreferences.getInstance();

// // Save an integer value to 'counter' key.
// await prefs.setInt('counter', 10);
  factory Student.fromMap(Map<String, dynamic> data) {
    final institutionId = data['institutionId'];
    final status = data['status'];

    return Student(institutionId: institutionId, status: status);
  }
}

//getting Students data
Future<Student> getStudent(docName) async {
  Student a = Student(institutionId: "noData", status: "noData");
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("students")
        .doc("$docName")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      } else {
        a = Student.fromMap(snapshot.data()!);
      }
    } else {
      return a;
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }
  return a;
}

Future<String> getName(docName) async {
  print(docName);
  String name = "";
  await getNamefromSp().then((value) async {
    name = value;
    print("${value.toString()} recieved locally");
  });
  if (name != "noData" || name == "") {
    getNamefromDb(docName).then((value) {
      name = value;
      print("${value.toString()} recieved from friebase");
    });
  } else {
    return name;
  }
  return name;
}

//getting name from database
Future<String> getNamefromDb(docName) async {
  print("get name from db is called");
  String a = "";
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("students")
        .doc("$docName")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      } else {
        a = "${snapshot.data()!['firstName']} ${snapshot.data()!['lastName']}";
        print(a);
        setNameinSp(a);
      }
    } else {
      return a;
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }

  return a;
}

//getting name from shared preferences
Future<String> getNamefromSp() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();
  // final name = prefs.getStringList('name');
  final List<String>? name = prefs.getStringList('name');
  if (name != null) {
    if (name.isNotEmpty) {
      return "${name[0].toString()} ${name[1].toString()}";
    } else {
      return "noData";
    }
  } else {
    return "noData";
  }
}

//set name in sp
void setNameinSp(String a) async {
  List<String> name = a.split(" ");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('name', name);
}

//delete name from local storage
void deleteName() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('firstName');
  await prefs.remove('lastName');
  print('deleted');
}
