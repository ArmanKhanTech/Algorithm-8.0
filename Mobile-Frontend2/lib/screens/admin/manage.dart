import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:algorithm/models/user_model.dart';
import 'package:algorithm/utilities/firebase.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<UserModel> users = [];

  showSnackBar(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: msg,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Manage Accounts",
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
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Users',
                style: TextStyle(
                  color: Colors.blue,
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
                stream: usersRef.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                      ),
                    );
                  }

                  users = snapshot.data!.docs
                      .map((QueryDocumentSnapshot doc) => UserModel.fromJson(
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
                              users[index].name!,
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
                              '${users[index].email!} | ${users[index].type!}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                usersRef.doc(users[index].id).delete().then(
                                    (value) =>
                                        showSnackBar("User Deleted.", context));
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
