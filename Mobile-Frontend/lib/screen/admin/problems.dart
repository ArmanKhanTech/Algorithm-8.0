import 'package:algorithm/utility/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:algorithm/model/query_model.dart';
import 'package:algorithm/utility/firebase.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({Key? key}) : super(key: key);

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  List<QueryModel> probs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Reports",
          style: TextStyle(
            fontSize: 25,
            color: Colors.green,
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
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Problems',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder(
                stream: probRef.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                    );
                  }

                  probs = snapshot.data!.docs
                      .map((QueryDocumentSnapshot doc) => QueryModel.fromJson(
                          doc.data() as Map<String, dynamic>))
                      .toList();

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                              width: .5,
                            )),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                            title: Text(
                              probs[index].prob!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            subtitle: Text(
                              '${probs[index].email!} | ${probs[index].name!}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                probRef
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete()
                                    .then((value) {
                                  showSnackBar(
                                      "Problem resolved successfully", context);
                                });
                              },
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ])),
    );
  }
}
