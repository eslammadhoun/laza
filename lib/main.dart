import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laza/view_models/get_started_viewmodel.dart';
import 'package:laza/view_models/home_viewmodel.dart';
import 'package:laza/view_models/login_view_model.dart';
import 'package:laza/view_models/signup_viewmodel.dart';
import 'package:laza/views/first_pages/get_started_page.dart';
import 'package:laza/views/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewmodel()),
        ChangeNotifierProvider(create: (_) => GetStartedViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return GetStartedPage();
          }
        },
      ),
    );
  }
}
