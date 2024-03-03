import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference teamsRef = firestore.collection('teams');
CollectionReference usersRef = firestore.collection('users');
CollectionReference hospRef = firestore.collection('hospitality');
CollectionReference judgeRef = firestore.collection('judge');
CollectionReference probRef = firestore.collection('problems');
CollectionReference annRef = firestore.collection('announcements');
