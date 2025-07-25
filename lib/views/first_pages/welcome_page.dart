import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:laza/views/first_pages/get_started_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffB0A3E5), Color(0xff7661C5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(top: -50, left: -50, child: _blurredCircle(250)),
          Positioned(top: 500, left: -50, child: _blurredCircle(150)),
          Positioned(bottom: 100, right: -35, child: _blurredCircle(250)),
          Center(
            child: Image.asset(
              "assets/images/welcome_page_img.png",
              scale: 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: _welcomeBox(screenWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blurredCircle(double size) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.60),
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _welcomeBox(double screenWidth) {
    return Container(
      width: (screenWidth - 30),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Look Good, Feel Good",
              style: TextStyle(
                color: Color(0xff1D1E20),
                fontSize: 25,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            "Create your individual & unique style and look amazing everyday.",
            style: TextStyle(
              color: Color(0xff8F959E),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 60,
                width: (screenWidth - 80) / 2,
                decoration: BoxDecoration(
                  color: Color(0xffF5F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Men",
                    style: TextStyle(
                      color: Color(0xff8F959E),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                width: (screenWidth - 80) / 2,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0XFF9775FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Women",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextButton(
            child: Text(
              "Skip",
              style: TextStyle(
                color: Color(0xff8F959E),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetStartedPage()),
            ),
          ),
        ],
      ),
    );
  }
}
