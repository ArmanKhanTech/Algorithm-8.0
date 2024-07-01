import 'package:flutter/material.dart';

import 'package:algorithm/utility/firebase.dart';
import 'package:algorithm/model/user_model.dart';

import '../../utility/common.dart';

class MakeAnnoucements extends StatefulWidget {
  final UserModel user;

  const MakeAnnoucements({super.key, required this.user});

  @override
  State<MakeAnnoucements> createState() => _MakeAnnoucementsState();
}

class _MakeAnnoucementsState extends State<MakeAnnoucements> {
  String ann = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Make Announcements",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Type your announcement here.",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  ann = val;
                });
              },
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: .5),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => {
                  annRef.add({
                    'announcement': ann,
                    'name': widget.user.name
                  }).then((value) => showSnackBar(
                      'Your problem is reported successfully.', context)),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
