import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laza/view_models/get_started_viewmodel.dart';
import 'package:laza/views/auth/login_page.dart';
import 'package:laza/views/auth/signup_page.dart';
import 'package:provider/provider.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    final getStartedVM = Provider.of<GetStartedViewmodel>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F6FA),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Color(0xff1D1E20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Let’s Get Started",
                    style: TextStyle(
                      color: Color(0xff1D1E20),
                      fontSize: 28,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                loginMethod(
                  "Facebook",
                  "assets/icons/Facebook.svg",
                  Color(0xff4267B2),
                  () {
                    try {
                      getStartedVM.signInWithFacebook();
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                SizedBox(height: 10),
                loginMethod(
                  "Twitter",
                  "assets/icons/Twitter.svg",
                  Color(0xff1DA1F2),
                  () => print("Taped!"),
                ),
                SizedBox(height: 10),
                loginMethod(
                  "Google",
                  "assets/icons/Google.svg",
                  Color(0xffEA4335),
                  () => print("Taped!"),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color(0xff8F959E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Signin",
                      style: TextStyle(
                        color: Color(0xff1D1E20),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => SignupPage())),
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff9775FA),
                  child: Center(
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loginMethod(
    String methodName,
    String methodIconPath,
    Color backgroundColor,
    void Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(methodIconPath, width: 30),
              SizedBox(width: 5),
              Text(
                methodName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
