import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laza/views/first_pages/get_started_page.dart';

class HomeViewmodel extends ChangeNotifier {
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("User Signed Out")));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GetStartedPage()),
    );
  }
}
