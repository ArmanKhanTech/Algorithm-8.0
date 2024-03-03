import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

import 'package:algorithm/models/team_model.dart';
import 'package:algorithm/models/user_model.dart';
import 'package:algorithm/utilities/firebase.dart';
import 'package:algorithm/widgets/circular_progress.dart';

// ignore: must_be_immutable
class EvaluateScreen extends StatefulWidget {
  final TeamModel team;

  final UserModel user;

  const EvaluateScreen({super.key, required this.team, required this.user});

  @override
  State<EvaluateScreen> createState() => _EvaluateScreenState();
}

class _EvaluateScreenState extends State<EvaluateScreen> {
  bool loading = false;

  int solution = 0;
  int presentation = 0;
  int completion = 0;
  int teamwork = 0;
  int socialImpact = 0;
  int scalability = 0;
  int uiUx = 0;
  int usp = 0;
  int fossImpact = 0;

  showErrorSnackBar(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: msg,
      ),
    );
  }

  showSuccSnackBar(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: msg,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        progressIndicator: CircularProgress(context, const Color(0xFF2196F3)),
        opacity: 0.5,
        color: Theme.of(context).colorScheme.background,
        isLoading: loading,
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Evaluate",
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.team.teamName!,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '(Marks in range of 1 - 5)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: .5,
                        ),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Judge ${widget.user.name!}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Solution',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            solution = temp;
                          } else {
                            solution = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Presentation',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            presentation = temp;
                          } else {
                            presentation = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Completion',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            completion = temp;
                          } else {
                            completion = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Team Work',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            teamwork = temp;
                          } else {
                            teamwork = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Social Impact',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            socialImpact = temp;
                          } else {
                            socialImpact = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Scalability',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            scalability = temp;
                          } else {
                            scalability = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'UI/UX',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            uiUx = temp;
                          } else {
                            uiUx = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Unique Selling Point',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            usp = temp;
                          } else {
                            usp = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'FOSS Impact',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          int temp = int.parse(val);
                          if (temp >= 1 && temp <= 5) {
                            fossImpact = temp;
                          } else {
                            fossImpact = 0;
                            showErrorSnackBar(
                                'Marks should be in the range of 1 to 5.',
                                context);
                          }
                        });
                      },
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Your Marks',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          var evals = await judgeRef
                              .where('teamName',
                                  isEqualTo: widget.team.teamName)
                              .where('judgeName', isEqualTo: widget.user.name)
                              .get();
                          if (evals.docs.isNotEmpty) {
                            // ignore: use_build_context_synchronously
                            showErrorSnackBar(
                                'You have already evaluated this team.',
                                context);
                            setState(() {
                              loading = false;
                            });
                            return;
                          } else if (solution == 0 ||
                              presentation == 0 ||
                              completion == 0 ||
                              teamwork == 0 ||
                              socialImpact == 0 ||
                              scalability == 0 ||
                              uiUx == 0 ||
                              usp == 0) {
                            // ignore: use_build_context_synchronously
                            showErrorSnackBar(
                                'Please fill all the fields or Maybe you are exceeding the given range.',
                                context);
                            setState(() {
                              loading = false;
                            });
                            return;
                          } else {
                            String id = const Uuid().v4();

                            await judgeRef.doc(id).set({
                              'id': id,
                              'judgeName': widget.user.name.toString(),
                              'teamName': widget.team.teamName.toString(),
                              'evaluatedAt': Timestamp.now(),
                              'solution': solution,
                              'presentation': presentation,
                              'completion': completion,
                              'teamwork': teamwork,
                              'socialImpact': socialImpact,
                              'scalability': scalability,
                              'uiUx': uiUx,
                              'usp': usp,
                              'fossImpact': fossImpact,
                              'totalMarks': solution +
                                  presentation +
                                  completion +
                                  teamwork +
                                  socialImpact +
                                  scalability +
                                  uiUx +
                                  usp +
                                  fossImpact,
                            });

                            // ignore: use_build_context_synchronously
                            showSuccSnackBar(
                                'Marks submitted successfully.', context);
                            setState(() {
                              loading = false;
                            });
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // TODO : Add loader
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
