import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/views/home_page.dart';

class LoginViewModel extends ChangeNotifier {
  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Succ")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException code: ${e.code}");
      if (e.code == 'invalid-credential') { 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email or Password is incorrect")),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email Not Found")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Wrong Password")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login Failed: ${e.code}")));
      }
    }
  }
}
