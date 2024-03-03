import 'package:flutter/material.dart';

import 'package:algorithm/models/user_model.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  UserModel? user;

  ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.purple,
                size: 25,
              ),
              title: Text(
                widget.user?.name ?? 'Not Found',
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.purple,
                size: 25,
              ),
              title: Text(
                widget.user?.email ?? 'Not Found',
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.work,
                color: Colors.purple,
                size: 25,
              ),
              title: Text(
                widget.user?.type ?? 'Not Found',
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
