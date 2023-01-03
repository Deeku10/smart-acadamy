import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question extends ChangeNotifier {
  String question;
  List<String> options;
  List<int> answers;

  Question(
      {required this.question, required this.options, required this.answers});

  factory Question.fromMap(Map<String, dynamic> data) {
    String question = data['question'];
    List<String> options = [];
    List<int> answers = [];

    options.add(data["a"].toString());
    options.add(data["b"].toString());
    options.add(data["c"].toString());
    options.add(data["d"].toString());
    answers.add(-1);
    return Question(question: question, options: options, answers: answers);
  }
}

class QuestionIndexProvider extends ChangeNotifier {
  int index;
  QuestionIndexProvider({
    this.index = 0,
  });

  void changeIndex(int indexFromUser) {
    index = indexFromUser;
    notifyListeners();
    print("$index is the index from provider");
  }
}

//getting question
Future<List<Question>> getQuestion(docName) async {
  List<Question> a = [];
  print("reached getquestions");
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("questions")
        .doc("$docName")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      } else {
        for (var e in snapshot.data()!['questions']) {
          a.add(Question.fromMap(e));
          if (answer.length + 1 == a.length) {
            answer.add(-1);
          }
        }
        // print("question data" + a.toString()); // a.add("noData");
      }
    } else {
      return a;
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }
  return a;
}

clearAnswer() {
  print("hello");
  print(answer.toString());
  answer.clear();
  print(answer.toString());
}

List<int> answer = [];
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
//   Question(
//       question: "Solve : 7x – 2 = 8 - x",
//       options: ["5/3	", "5/4", "3/5", "4/5"],
//       answers: [-1]),
//   Question(
//     question: "Solve :  2x – 6 = 0",
//     options: ["3", "4", "5", "6"],
//     answers: [1],
//   ),
//   Question(
//     question: "Solve : 8 – 2x = 5 – 4x",
//     options: ["-2/3", "2/3", "3/2", "-3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 2(x – 1) + 2(3x -1) = 0",
//     options: ["1/2", "1", "2", "2/3"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve : 4(x-1) –(2x – 5) = 4",
//     options: ["4/5", "5/4", "2/3", "3/2"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  10(y – 4) – 2(y – 9) – 5(y + 4) = 0",
//     options: ["12", "14", "10", "8"],
//     answers: [-1],
//   ),
//   Question(
//     question: "Solve :  (2x+5)/(3x+4)  = 5",
//     options: ["11/7", "7/4", "7/11", "12"],
//     answers: [2],
//   ),
// ];
