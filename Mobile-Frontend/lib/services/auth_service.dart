import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:algorithm/utilities/firebase.dart';

class AuthService {
  User getCurrentUser() {
    User user = auth.currentUser!;
    return user;
  }

  Future<bool> loginUser({String? email, String? password}) async {
    var res = await auth.signInWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );
    if (res.user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createUser({
    String? name,
    String? email,
    String? password,
    String? type,
  }) async {
    try {
      Uuid uuid = const Uuid();
      await saveUserToFirestore(name!, email!, type!, uuid.v4());
      return true;
    } catch (e) {
      return false;
    }
  }

  saveUserToFirestore(
    String name,
    String email,
    String type,
    String uid,
  ) async {
    await usersRef.doc(uid.toString()).set({
      'id': uid,
      'name': name,
      'email': email,
      'type': type,
    });
  }

  forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  logOut() async {
    await auth.signOut();
  }

  String handleFirebaseAuthError(String e) {
    if (e.contains("ERROR_WEAK_PASSWORD")) {
      return "Password is too weak.";
    } else if (e.contains("invalid-email")) {
      return "Invalid email.";
    } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
        e.contains('email-already-in-use')) {
      return "The email address is already in use by another account.";
    } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
      return "Network error occurred!";
    } else if (e.contains("ERROR_USER_NOT_FOUND") ||
        e.contains('firebase_auth/user-not-found')) {
      return "Invalid credentials.";
    } else if (e.contains("ERROR_WRONG_PASSWORD") ||
        e.contains('wrong-password')) {
      return "Invalid credentials.";
    } else if (e.contains('firebase_auth/requires-recent-login')) {
      return 'This operation is sensitive and requires recent authentication.'
          ' Log in again before retrying this request again.';
    } else {
      return e;
    }
  }
}
