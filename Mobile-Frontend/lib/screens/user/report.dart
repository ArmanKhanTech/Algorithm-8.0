import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:algorithm/utilities/firebase.dart';
import 'package:algorithm/models/user_model.dart';

class ReportScreen extends StatefulWidget {
  final UserModel user;

  const ReportScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ReportScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<ReportScreen> {
  String prob = '';

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
          "Report",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
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
              "Please describe the problem you are facing with the app. We will try to resolve it as soon as possible.",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  prob = val;
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
                backgroundColor: Colors.green,
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
                  probRef.add({
                    'problem': prob,
                    'name': widget.user.name,
                    'email': widget.user.email,
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
