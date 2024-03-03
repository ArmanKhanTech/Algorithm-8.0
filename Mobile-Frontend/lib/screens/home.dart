import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:algorithm/models/user_model.dart';
import 'package:algorithm/models/team_model.dart';
import 'package:algorithm/utilities/firebase.dart';
import 'package:algorithm/utilities/constants.dart';
import 'package:algorithm/screens/user/profile.dart';
import 'package:algorithm/screens/user/report.dart';
import 'package:algorithm/screens/admin/register.dart';
import 'package:algorithm/screens/admin/manage.dart';
import 'package:algorithm/screens/admin/marks.dart';
import 'package:algorithm/screens/hosp/log_activity.dart';
import 'package:algorithm/screens/judge/evaluate.dart';
import 'package:algorithm/screens/web.dart';
import 'package:algorithm/screens/teams/details.dart';
import 'package:algorithm/screens/admin/problems.dart';
import 'package:algorithm/screens/admin/make_annoucements.dart';
import 'package:algorithm/screens/user/announcements.dart';
import 'package:algorithm/screens/auth/login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserModel? user;

  String? search = '';

  late TextEditingController searchController;

  bool called = false;

  List<TeamModel> teams = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(onSearchChanged);
    getUser();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged() {
    setState(() {
      search = searchController.text;
    });
  }

  Future<void> getUser() async {
    try {
      DocumentSnapshot doc = await usersRef
          .where('email', isEqualTo: auth.currentUser?.email)
          .get()
          .then((value) => value.docs.first);

      if (doc.exists) {
        if (auth.currentUser?.email == doc['email']) {
          setState(() {
            user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  openDailog(TeamModel team) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Where to?',
              style: TextStyle(color: Constants.orange, fontSize: 25)),
          icon: const Icon(Icons.map, color: Constants.orange, size: 30),
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Constants.orange,
              width: .5,
            ),
          ),
          content: SizedBox(
            height: 125,
            width: 300,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Team Details',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading:
                      const Icon(Icons.info, color: Constants.orange, size: 30),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DetailsScreen(
                          team: team,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Log Activity',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  leading:
                      const Icon(Icons.work, color: Constants.orange, size: 30),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => LogActivityScreen(
                          team: team,
                        ),
                      ),
                    );
                  },
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
              "Algorithm 8.0",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEA580C),
              ),
            ),
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                iconSize: 30,
              ),
            ),
            surfaceTintColor: Colors.transparent),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),
            child: Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Teams',
                  style: TextStyle(
                    color: Constants.orange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: searchController,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Constants.orange,
                      width: .5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Constants.orange,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: teamsRef.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Constants.orange,
                          ),
                        ),
                      );
                    }

                    // add to list only if status == 'pass' and teamName is not null
                    teams = snapshot.data!.docs
                        .map((doc) => TeamModel.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .where((team) => team.status == 'pass')
                        .toList();

                    return ListView.builder(
                      itemCount: teams.length,
                      itemBuilder: (BuildContext context, int index) {
                        final team = teams[index];

                        if (search != null &&
                            !team.teamName!
                                .toLowerCase()
                                .contains(search!.toLowerCase())) {
                          return const SizedBox();
                        }

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
                                team.teamName!,
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
                                '${team.collegeLead!} | ${team.nameLead!}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                if (user?.type == 'Admin') {
                                  openDailog(team);
                                } else if (user?.type == 'Judge') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => EvaluateScreen(
                                        team: team,
                                        user: user!,
                                      ),
                                    ),
                                  );
                                } else if (user?.type == 'Hosp') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => LogActivityScreen(
                                        team: team,
                                      ),
                                    ),
                                  );
                                }
                              },
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Constants.orange,
                                size: 20,
                              )),
                        );
                      },
                    );
                  },
                ),
              ),
            ])),
        extendBody: false,
        extendBodyBehindAppBar: false,
        drawer: SafeArea(
          child: Drawer(
              backgroundColor: Colors.black,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        border: Border(
                          right: BorderSide(color: Constants.orange, width: .5),
                          bottom:
                              BorderSide(color: Constants.orange, width: .5),
                          top: BorderSide(color: Constants.orange, width: .5),
                        )),
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                            title: Row(
                          children: [
                            const Text(
                              'Menu',
                              style: TextStyle(
                                color: Constants.orange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                CupertinoIcons.globe,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => WebScreen(
                                      url: 'https://algorithm8.aiktc.ac.in/',
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        )),
                        ListTile(
                          title: const Text('Your Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          leading:
                              const Icon(Icons.person, color: Colors.white),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(user: user!)));
                          },
                        ),
                        Visibility(
                          visible: user?.type == 'Admin',
                          child: ListTile(
                            title: const Text('View Marks',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            leading:
                                const Icon(Icons.book, color: Colors.white),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const MarksScreen()));
                            },
                          ),
                        ),
                        Visibility(
                          visible: user?.type == 'Admin',
                          child: ListTile(
                            title: const Text('New Account',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            leading: const Icon(Icons.person_add,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                          ),
                        ),
                        Visibility(
                          visible: user?.type == 'Admin',
                          child: ListTile(
                            title: const Text('Manage Accounts',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            leading: const Icon(Icons.manage_accounts,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ManageScreen()));
                            },
                          ),
                        ),
                        Visibility(
                          visible: user?.type == 'Admin',
                          child: ListTile(
                            title: const Text('Make Announcements',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            leading: const Icon(Icons.announcement,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          MakeAnnoucements(user: user!)));
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Announcements',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          leading: const Icon(Icons.announcement,
                              color: Colors.white),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const AnnouncementsScreen(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Report a Problem',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          leading: const Icon(Icons.add, color: Colors.white),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ReportScreen(user: user!)));
                          },
                        ),
                        Visibility(
                          visible: user?.type == 'Admin',
                          child: ListTile(
                            title: const Text('Manage Problems',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            leading: const Icon(Icons.bug_report_rounded,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ProblemsScreen()));
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Logout',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)),
                          leading: const Icon(Icons.logout, color: Colors.red),
                          onTap: () async {
                            await auth.signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (_) => const LoginScreen()),
                                  (route) => false);
                            });
                          },
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}
