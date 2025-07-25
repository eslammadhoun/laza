import 'package:flutter/material.dart';
import 'package:laza/components/formField.dart';
import 'package:laza/view_models/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool rememberMe = false;
  TextEditingController usernameController = TextEditingController();
  bool isUserNameValid = false;
  TextEditingController passwordController = TextEditingController();
  bool isPasswordStrong = false;
  TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      setState(() {
        isUserNameValid = usernameController.text.trim().length >= 6;
      });
    });
    passwordController.addListener(() {
      setState(() {
        isPasswordStrong = passwordController.text.trim().length >= 6;
      });
    });
    emailController.addListener(() {
      setState(() {
        isEmailValid =
            (emailController.text.isNotEmpty &&
            emailController.text.trim().length >= 6 &&
            emailController.text.contains("@"));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final signupVM = Provider.of<SignupViewmodel>(context);

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
                    "Sign Up",
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        labelText: "Username",
                        suffixWidget: isUserNameValid
                            ? Icon(Icons.check, color: Color(0xff34C759))
                            : Icon(Icons.check, color: Colors.transparent),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter User Name';
                          } else if (value.length < 6) {
                            return 'Username must be at lease 6 Char';
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20),
                      CustomFormField(
                        labelText: "Password",
                        suffixWidget: isPasswordStrong
                            ? Text(
                                "Strong",
                                style: TextStyle(color: Color(0xff34C559)),
                              )
                            : Text(
                                "Weak Password",
                                style: TextStyle(color: Colors.red),
                              ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Strong Password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      CustomFormField(
                        labelText: "Email Address",
                        suffixWidget: isEmailValid
                            ? Icon(Icons.check, color: Color(0xff34C559))
                            : SizedBox.shrink(),
                        validator: (value) {
                          if (!value!.contains('@')) {
                            return 'Please Enter Valid Email';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remember me",
                      style: TextStyle(
                        color: Color(0xff1D1E20),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Switch(
                      activeTrackColor: Color(0xff34C759),
                      value: rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          rememberMe = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    await signupVM.signUp(
                      context,
                      emailController.text,
                      passwordController.text,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff9775FA),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Sign Up",
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
}
