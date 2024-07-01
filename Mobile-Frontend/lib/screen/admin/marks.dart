import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:algorithm/model/eval_model.dart';
import 'package:algorithm/utility/firebase.dart';
import 'package:algorithm/screen/admin/team_results.dart';

class MarksScreen extends StatefulWidget {
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  List<dynamic> evals = [];
  List<Evaluation> evaluations = [];

  @override
  void initState() {
    super.initState();
    getMarks();
  }

  Future<void> getMarks() async {
    await judgeRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        evals.add(EvalModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    });

    for (var eval in evals) {
      var totalMarks = evals
          .where((element) => element.teamName == eval.teamName)
          .map((e) => e.totalMarks)
          .reduce((value, element) => value + element);

      evaluations.add(Evaluation(
        teamName: eval.teamName,
        totalMarks: totalMarks,
      ));
    }

    evaluations.sort((a, b) => b.totalMarks!.compareTo(a.totalMarks!));

    for (var i = 0; i < evaluations.length; i++) {
      for (var j = i + 1; j < evaluations.length; j++) {
        if (evaluations[i].teamName == evaluations[j].teamName) {
          evaluations.removeAt(j);
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Evaluations",
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 30,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  evals = [];
                  evaluations = [];
                });
                getMarks();
              },
              iconSize: 30,
            ),
            const SizedBox(width: 10)
          ],
          surfaceTintColor: Colors.black),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          child: ListView(
            children: evaluations
                .map((e) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        leading: Text(
                          (evaluations.indexOf(e) + 1).toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        title: Text(e.teamName!,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(e.totalMarks.toString(),
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    TeamResultsScreen(teamName: e.teamName!),
                              ));
                        },
                      ),
                    ))
                .toList(),
          )),
    );
  }
}

class Evaluation {
  String? teamName;
  int? totalMarks;

  Evaluation({this.teamName, this.totalMarks});

  Evaluation.fromJson(Map<String, dynamic> json) {
    teamName = json['teamName'];
    totalMarks = json['totalMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teamName'] = teamName;
    data['totalMarks'] = totalMarks;
    return data;
  }
}
