import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscure = true;
  bool isChecked = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void errorMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          constraints: BoxConstraints(minWidth: 300),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/animations/error.json",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "OK",
                  style: GoogleFonts.urbanist(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      if (emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty) {
        errorMessage(
          "Credentials are required",
          "Please enter your email id and password",
        );
      } else if (emailController.text.trim().isEmpty) {
        errorMessage(
          "Email is required",
          "Please enter your email id.",
        );
      } else if (passwordController.text.trim().isEmpty) {
        errorMessage(
          "Password is required",
          "Please enter your password.",
        );
      } else if (e.code == "invalid-email") {
        errorMessage(
          "Invalid Email Format",
          "The email id is badly formatted.",
        );
      } else if (e.code == "invalid-credential") {
        errorMessage(
          "Invalid Email/Password",
          "Please enter correct email or password",
        );
      } else if (e.code == "user-disabled") {
        errorMessage(
          "Account Disabled",
          "This user account has been disabled.",
        );
      } else if (e.code == "too-many-requests") {
        errorMessage(
          "Too Many Requests",
          "Too many unsuccessful login attempts. Please try again later.",
        );
      }  else {
        errorMessage("Login Error", e.message ?? "An unknown error occurred.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(15, 15, 15, 1),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        body: GestureDetector(
          onTap: () {
            setState(() {
              emailFocus.unfocus();
              passwordFocus.unfocus();
            });
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 330,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: const Offset(40, 10),
                        child: Image.asset(
                          "assets/images/background_login4.png",
                          width: width,
                          height: 500,
                        ),
                      ),

                      Positioned(
                        top: 70,
                        left: 20,
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step Into,",
                              style: GoogleFonts.playfairDisplay(
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(1),
                                    offset: Offset(0, 0),
                                    blurRadius: 100,
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "OverCloud",
                              style: GoogleFonts.playfairDisplay(
                                shadows: [
                                  Shadow(
                                    color: Colors.deepOrange.withOpacity(1),
                                    offset: const Offset(0, 0),
                                    blurRadius: 100,
                                  ),
                                ],
                                color: Colors.deepOrange,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 0.5,
                              width: 200,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "The Cloud, Reimagined",
                              style: GoogleFonts.playfairDisplay(
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.8),
                                    offset: Offset(0, 0),
                                    blurRadius: 100,
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Secure. Scalable. Limitless.",
                              style: GoogleFonts.urbanist(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Everything in one cloud.",
                              style: GoogleFonts.urbanist(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.easeInBack,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  transform: Matrix4.translationValues(
                    0,
                    MediaQuery.of(context).viewInsets.bottom > 0 ? -280 : 0,
                    0,
                  ),
                  child: Container(
                    width: width,

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      color: Color.fromRGBO(29, 29, 29, 0.8235294117647058),
                      border: const BorderDirectional(
                        top: BorderSide(color: Colors.white24, width: 0.5),
                        start: BorderSide(color: Colors.white24, width: 0.5),
                        end: BorderSide(color: Colors.white24, width: 0.5),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 150.0,
                          ),
                          child: Divider(
                            color: Colors.white24,
                            height: 5,
                            thickness: 5,
                            radius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(height: 30),
                        customTextField(
                          "Email",
                          emailController,
                          emailFocus,
                          false,
                          Icons.email_outlined,
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          "Password",
                          passwordController,
                          passwordFocus,
                          obscure,
                          Icons.lock_outline_rounded,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.deepOrange,
                                    value: isChecked,
                                    onChanged: ((value) => setState(() {
                                      isChecked = value!;
                                    })),
                                  ),
                                  Text(
                                    "Remember Me",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.deepOrange.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, -5),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF7A00), Color(0xFFFF3D00)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                minimumSize: Size(width, 45),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Text(
                                    "Sign In",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    color: Colors.white70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Container(
                                    height: 0.5,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                              Text(
                                "Or Continue With",
                                style: GoogleFonts.urbanist(
                                  color: Colors.white70,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Container(
                                    height: 0.5,
                                    width: double.infinity,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white24,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(29, 29, 29, 1),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/logos/google_logo.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Google",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.urbanist(
                                color: Colors.white54,
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Sign Up
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.urbanist(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget obscureIcon() {
    if (obscure) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
          icon: FaIcon(FontAwesomeIcons.eye, color: Colors.white54, size: 20),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
          icon: FaIcon(
            FontAwesomeIcons.eyeSlash,
            color: Colors.white54,
            size: 20,
          ),
        ),
      );
    }
  }

  Widget customTextField(
    String hint,
    TextEditingController controller,
    FocusNode focusNode,
    bool obscure,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          color: Color.fromRGBO(29, 29, 29, 1),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white38, width: 0.3),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(icon, color: Colors.white54, size: 25),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscure,
                style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16),
                focusNode: focusNode,
                onSubmitted: (value){
                  if(emailFocus.hasFocus){
                    FocusScope.of(context).requestFocus(passwordFocus);
                  }
                  else{
                    login();
                  }
                },


                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: GoogleFonts.urbanist(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            controller == passwordController ? obscureIcon() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
