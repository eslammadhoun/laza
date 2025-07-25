import 'package:flutter/material.dart';
import 'package:laza/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homePageVM = Provider.of<HomeViewmodel>(context);
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => homePageVM.logout(context)
        ),
      ),
    );
  }
}