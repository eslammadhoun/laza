import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:laza/components/formField.dart';
import 'package:laza/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = true;
  TextEditingController passwordController = TextEditingController();
  bool isPasswordStrong = false;
  TextEditingController emailController = TextEditingController();
  bool isEmailValid = false;
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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
    final loginVM = Provider.of<LoginViewModel>(context);
    
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
                  child: Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Color(0xff1D1E20),
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Please enter your data to continue",
                        style: TextStyle(
                          color: Color(0xff8F959E),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
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
                            return 'Please Enter the Password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 30),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text.rich(
                  TextSpan(
                    text:
                        "By connecting your account confirm that you agree with our ",
                    style: TextStyle(
                      color: Color(0xff8F959E),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    children: [
                      TextSpan(
                        text: "Term and Condition",
                        style: TextStyle(
                          color: Color(0xff1D1E20),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('Taped'),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    await loginVM.login(context, emailController.text, passwordController.text);
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
                            "Login",
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
