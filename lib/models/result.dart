import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_acadamy/models/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Result extends ChangeNotifier {
  int correct;
  int wrong;
  int notAnswered;
  int total;
  List<Answer> result;

  Result(
      {required this.correct,
      required this.wrong,
      required this.notAnswered,
      required this.total,
      required this.result});

  factory Result.fromMap(Map<String, dynamic> data) {
    int correct = data['result']['data']['correct'];
    int wrong = data['result']['data']['wrong'];
    int notAnswered = data['result']['data']['notAnswered'];
    int total = data['result']['data']['marks'];
    List<Answer> a = [];

    for (var e in data['result']['data']['answers']) {
      a.add(Answer.fromMap(e));
    }
    return Result(
        correct: correct,
        wrong: wrong,
        notAnswered: notAnswered,
        total: total,
        result: a);
  }
}

class Answer {
  int answer;
  int marks;
  String status;
  Answer({
    required this.answer,
    required this.marks,
    required this.status,
  });
  factory Answer.fromMap(Map<String, dynamic> data) {
    int marks = data['marks'];
    String status = data['status'];
    var k = data['answer'];
    int answer;
    if (k == "b") {
      answer = 1;
    } else if (k == "a") {
      answer = 0;
    } else if (k == "c") {
      answer = 2;
    } else if (k == "d") {
      answer = 3;
    } else {
      answer = -1;
    }
    return Answer(answer: answer, marks: marks, status: status);
  }
}

Future<Result> submitExam(String qid, List answers, String uid) async {
  Map answerSheet = {
    "data": {"uid": uid, "questionsId": qid, "answers": []}
  };
  List formattedAnswers = [];

  for (var answer in answers) {
    Map formattedAnswer = {"answer": null};
    if (answer == 0) {
      formattedAnswer = {"answer": "a"};
    } else if (answer == 1) {
      formattedAnswer = {"answer": "b"};
    } else if (answer == 2) {
      formattedAnswer = {"answer": "c"};
    } else if (answer == 3) {
      formattedAnswer = {"answer": "d"};
    }
    formattedAnswers.add(formattedAnswer);
  }

  answerSheet['data']['answers'] = formattedAnswers;

  final response = await http.post(
    Uri.parse(
        'https://us-central1-thesmartacademyofficial.cloudfunctions.net/attempt'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(answerSheet),
  );
  print(answerSheet.toString());
  print("this is response" + response.body);
  print("this is response json" + jsonDecode(response.body).toString());

  if (response.statusCode == 200) {
    // return Album.fromJson(jsonDecode(response.body));
    return Result.fromMap(jsonDecode(response.body));
  } else {
    return Result(
        correct: -1, wrong: -1, notAnswered: -1, total: -1, result: []);
  }
}

Future<List> getAnswers(docName) async {
  List a = [];

  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("attempts")
        .doc("$docName")
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      } else {
        for (var e in snapshot.data()!['answers']) {
          int k = -1;

          if (e["answer"] == "a") {
            k = 0;
          } else if (e["answer"] == "b") {
            k = 1;
          } else if (e["answer"] == "c") {
            k = 2;
          } else if (e["answer"] == "d") {
            k = 3;
          }
          print(k.toString() + "k is this");
          a.add(k);
        }
      }
    }
  } catch (e) {
    print(e.toString()); // a.add("noData");
  }
  print("this is a " + a.toString());
  return a;
}
