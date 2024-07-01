import 'package:algorithm/utility/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:algorithm/model/eval_model.dart';

class TeamResultsScreen extends StatefulWidget {
  final String teamName;

  const TeamResultsScreen({Key? key, required this.teamName}) : super(key: key);

  @override
  State<TeamResultsScreen> createState() => _TeamResultsScreenState();
}

class _TeamResultsScreenState extends State<TeamResultsScreen> {
  Future<dynamic> openDailog(EvalModel eval) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Marks Details',
              style: TextStyle(color: Colors.blue, fontSize: 25)),
          icon: const Icon(Icons.book, color: Colors.blue, size: 30),
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.blue,
              width: .5,
            ),
          ),
          content: SizedBox(
            height: 350,
            width: 300,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Solution",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.solution}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Presentation",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.presentation}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Completion",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.completion}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Teamwork",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.teamwork}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Socail Impact",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.socialImpact}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Scalability",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.scalability}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "UI/UX",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.uiUx}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "Unique Selling Point",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.usp}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "FOSS Impact",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Spacer(),
                    Text(
                      "${eval.fossImpact}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close',
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Marks",
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
          surfaceTintColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.teamName,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: judgeRef
                  .where('teamName', isEqualTo: widget.teamName)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  );
                }

                final List<QueryDocumentSnapshot> documents =
                    snapshot.data.docs;

                return Column(
                  children: documents.map((document) {
                    final EvalModel evalModel = EvalModel.fromJson(
                        document.data() as Map<String, dynamic>);

                    return GestureDetector(
                        onTap: () {
                          openDailog(evalModel);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white,
                              width: .5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${evalModel.judgeName}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${evalModel.totalMarks}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ));
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
