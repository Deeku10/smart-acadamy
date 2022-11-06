import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String institutionId, status;
  Student({
    required this.institutionId,
    required this.status,
  });
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
