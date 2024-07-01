import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

import 'package:algorithm/model/team_model.dart';
import 'package:algorithm/model/log_model.dart';
import 'package:algorithm/screen/teams/details.dart';
import 'package:algorithm/utility/firebase.dart';
import 'package:algorithm/widget/circular_progress.dart';

class LogActivityScreen extends StatefulWidget {
  final TeamModel team;

  const LogActivityScreen({super.key, required this.team});

  @override
  State<LogActivityScreen> createState() => _LogActivityScreenState();
}

class _LogActivityScreenState extends State<LogActivityScreen> {
  final formKey = GlobalKey<FormState>();

  List<String> items = [
    'Lab Entry',
    'Lab Exit',
    'Lunch (Day 1)',
    'Dinner (Day 1)',
    'Breakfast (Day 2)',
    'Lunch (Day 2)',
    'Dinner (Day 2)',
    'Entry College',
    'Exit College',
  ];

  List<LogModel> logs = [];

  String selectedActivity = 'No Activity Selected';

  bool isTeamActivity = false;
  bool leadSelected = false;
  bool member2Selected = false;
  bool member3Selected = false;
  bool loading = false;

  Future<dynamic> openImagePopup(String name, String role) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(role,
              style: const TextStyle(color: Colors.white, fontSize: 25)),
          icon: const Icon(Icons.image, color: Colors.teal, size: 30),
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.teal,
              width: .5,
            ),
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    role == 'Team Lead'
                        ? widget.team.imageLead!
                        : role == 'Team Member 2'
                            ? widget.team.imageMember2!
                            : widget.team.imageMember3!,
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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

  void submitLogEntry(BuildContext context) async {
    if (selectedActivity == 'No Activity Selected') {
      showSnackBar('Please select an activity.', context);
      return;
    } else if (!leadSelected && !member2Selected && !member3Selected) {
      showSnackBar('Please select at least one team member.', context);
      return;
    } else {
      String id = const Uuid().v4();

      try {
        setState(() {
          loading = true;
        });
        await hospRef.doc(id).set({
          'id': id,
          'timestamp': Timestamp.now(),
          'teamName': widget.team.teamName,
          'isTeamActivity': isTeamActivity,
          'memberName': [
            leadSelected ? widget.team.nameLead : null,
            member2Selected ? widget.team.nameMember2 : null,
            member3Selected ? widget.team.nameMember3 : null
          ],
          'activityType': selectedActivity,
        }).then((value) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: 'Log added successfully.',
            ),
          );
          setState(() {
            loading = false;
          });
        });
      } catch (error) {
        // ignore: use_build_context_synchronously
        showSnackBar('Error adding log: $error', context);
        setState(() {
          loading = false;
        });
      }
    }
  }

  void showSnackBar(String msg, context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: msg,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (leadSelected && member2Selected && member3Selected) {
      isTeamActivity = true;
    } else if (isTeamActivity) {
      leadSelected = true;
      member2Selected = true;
      member3Selected = true;
    }

    return LoadingOverlay(
        progressIndicator: CircularProgress(context, const Color(0xFF009688)),
        opacity: 0.5,
        color: Theme.of(context).colorScheme.surface,
        isLoading: loading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Log Activity",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 30,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DetailsScreen(
                        team: widget.team,
                      ),
                    ),
                  );
                },
                iconSize: 30,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: ListView(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Activities',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        value: selectedActivity == 'No Activity Selected'
                            ? null
                            : selectedActivity,
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 22,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.teal,
                        ),
                        dropdownColor: Colors.white,
                        menuMaxHeight: double.infinity,
                        isExpanded: true,
                        focusColor: Colors.teal,
                        hint: const Text('Select Activity'),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: .5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.teal,
                              width: 1,
                            ),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        autofocus: false,
                        items: items.map((option) {
                          return DropdownMenuItem(
                              value: option,
                              child: Text(
                                option,
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 22,
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() => selectedActivity = newValue!);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an activity.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            value: leadSelected,
                            title: Text(
                              widget.team.nameLead!,
                              style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            secondary: IconButton(
                              icon: const Icon(Icons.image, color: Colors.teal),
                              onPressed: () {
                                if (mounted) {
                                  openImagePopup(
                                    widget.team.nameLead!,
                                    "Team Lead",
                                  );
                                }
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.white,
                                width: .5,
                              ),
                            ),
                            checkColor: Colors.white,
                            checkboxShape: const CircleBorder(),
                            splashRadius: 20,
                            onChanged: (bool? newValue) {
                              setState(() {
                                leadSelected = newValue!;
                                isTeamActivity = false;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.teal,
                            visualDensity: VisualDensity.compact,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.team.nameMember2 != null
                              ? CheckboxListTile(
                                  value: member2Selected,
                                  title: Text(
                                    widget.team.nameMember2!,
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  secondary: IconButton(
                                    icon: const Icon(Icons.image,
                                        color: Colors.teal),
                                    onPressed: () {
                                      if (mounted) {
                                        openImagePopup(
                                          widget.team.nameMember2!,
                                          "Team Member 2",
                                        );
                                      }
                                    },
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: .5,
                                    ),
                                  ),
                                  checkColor: Colors.white,
                                  checkboxShape: const CircleBorder(),
                                  splashRadius: 20,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      member2Selected = newValue!;
                                      isTeamActivity = false;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.teal,
                                  visualDensity: VisualDensity.compact,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.team.nameMember3 != null
                              ? CheckboxListTile(
                                  value: member3Selected,
                                  title: Text(
                                    widget.team.nameMember3!,
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  secondary: IconButton(
                                    icon: const Icon(Icons.image,
                                        color: Colors.teal),
                                    onPressed: () {
                                      if (mounted) {
                                        openImagePopup(
                                          widget.team.nameMember3!,
                                          "Team Member 3",
                                        );
                                      }
                                    },
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: .5,
                                    ),
                                  ),
                                  checkColor: Colors.white,
                                  checkboxShape: const CircleBorder(),
                                  splashRadius: 20,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      member3Selected = newValue!;
                                      isTeamActivity = false;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.teal,
                                  visualDensity: VisualDensity.compact,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        value: isTeamActivity,
                        title: const Text(
                          'Applies to Entire Team?',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.white,
                            width: .5,
                          ),
                        ),
                        checkColor: Colors.white,
                        checkboxShape: const CircleBorder(),
                        splashRadius: 20,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isTeamActivity = newValue!;
                            leadSelected = false;
                            member2Selected = false;
                            member3Selected = false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.teal,
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45.0,
                        width: MediaQuery.of(context).size.width,
                        child: FloatingActionButton(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // TODO: Add loader
                          child: const Text(
                            'Log',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            submitLogEntry(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: hospRef
                      .where('teamName', isEqualTo: widget.team.teamName)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                        ));
                      default:
                        logs = snapshot.data!.docs
                            .map((DocumentSnapshot doc) => LogModel.fromJson(
                                doc.data() as Map<String, dynamic>))
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: logs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                tileColor: Colors.black,
                                title: Text(
                                  '${logs[index].activityType} on ${DateTime.parse(logs[index].timestamp.toString()).day}/${DateTime.parse(logs[index].timestamp.toString()).month} at ${DateFormat('hh:mm a').format(DateTime.parse(logs[index].timestamp.toString()))}',
                                  style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.teal,
                                    width: .5,
                                  ),
                                ),
                                subtitle: logs[index].isTeamActivity
                                    ? const Text(
                                        'Entire Team',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          logs[index].memberName[0] != null &&
                                                  logs[index].memberName[0] !=
                                                      ''
                                              ? Text(
                                                  logs[index].memberName[0]!,
                                                  style: const TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          logs[index].memberName[1] != null &&
                                                  logs[index].memberName[1] !=
                                                      ''
                                              ? Text(
                                                  logs[index].memberName[1]!,
                                                  style: const TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          logs[index].memberName[2] != null &&
                                                  logs[index].memberName[2] !=
                                                      ''
                                              ? Text(
                                                  logs[index].memberName[2]!,
                                                  style: const TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    hospRef
                                        .doc(logs[index].id)
                                        .delete()
                                        .then((value) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.success(
                                          message: 'Log deleted successfully.',
                                        ),
                                      );
                                    }).catchError((error) {
                                      showSnackBar('Error deleting log: $error',
                                          context);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                    }
                  },
                ),
              ])),
        ));
  }
}
