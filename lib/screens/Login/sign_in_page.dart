import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_auth_service.dart';

import 'package:overcloud/screens/login/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscure = true;
  bool isChecked = false;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 290,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/background_signin.png",
                            width: size.width,
                            height: 500,
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
                                  style: GoogleFonts.urbanist(
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        offset: Offset(0, 0),
                                        blurRadius: 100,
                                      ),
                                    ],
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(255, 123, 41, 1),
                                          Color.fromRGBO(205, 70, 22, 1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                  child: Text(
                                    "OverCloud",
                                    style: GoogleFonts.urbanist(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 15),
                                Container(
                                  height: 3,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(255, 123, 41, 1),
                                        Color.fromRGBO(205, 70, 22, 1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "The Cloud, Reimagined.",
                                  style: GoogleFonts.urbanist(
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 1,
                                        ),
                                        offset: Offset(0, 0),
                                        blurRadius: 50,
                                      ),
                                    ],
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  "Manage everything from\nSingle Cloud Platform.",
                                  style: GoogleFonts.urbanist(
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.white.withValues(
                                          alpha: 0.5,
                                        ),
                                        offset: Offset(0, 0),
                                        blurRadius: 100,
                                      ),
                                    ],
                                    color: Colors.white54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "SECURE",
                          style: GoogleFonts.urbanist(
                            shadows: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.5),
                                offset: Offset(0, 0),
                                blurRadius: 100,
                              ),
                            ],
                            color: Colors.deepOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          "✦",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          "SCALABLE",
                          style: GoogleFonts.urbanist(
                            shadows: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.5),
                                offset: Offset(0, 0),
                                blurRadius: 100,
                              ),
                            ],
                            letterSpacing: 2,
                            color: Colors.deepOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "✦",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          "LIMITLESS",
                          style: GoogleFonts.urbanist(
                            shadows: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.5),
                                offset: Offset(0, 0),
                                blurRadius: 100,
                              ),
                            ],
                            color: Colors.deepOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInBack,
                      margin: const EdgeInsets.symmetric(horizontal: 8),

                      transform: Matrix4.translationValues(
                        0,
                        MediaQuery.of(context).viewInsets.bottom > 0 ? -150 : 0,
                        0,
                      ),
                      child: Container(
                        width: size.width,

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(45, 45, 45, 0.95),
                              Color.fromRGBO(25, 25, 25, 0.95),
                            ],
                          ),
                          border: BorderDirectional(
                            top: BorderSide(color: Colors.white24, width: 1),
                            start: BorderSide(color: Colors.white24, width: 1),
                            end: BorderSide(color: Colors.white24, width: 1),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 23.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Welcome Back",
                                        style: GoogleFonts.urbanist(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        " !",
                                        style: GoogleFonts.urbanist(
                                          color: Colors.deepOrange,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),
                                  Text(
                                    "Sign in to your OverCloud Account",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white54,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),
                            customTextField(
                              "Email",
                              emailController,
                              emailFocus,
                              false,
                              Icons.email_outlined,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              "Password",
                              passwordController,
                              passwordFocus,
                              obscure,
                              Icons.lock_outline_rounded,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          fontSize: 13,
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
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 43,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.6,
                                        ),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                      BoxShadow(
                                        color: Colors.deepOrange.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 10,
                                        offset: Offset(0, -5),
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(255, 132, 61, 0.89),
                                        Color.fromRGBO(233, 89, 17, 1),
                                        Color.fromRGBO(205, 61, 0, 1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();

                                      _firebaseAuthService.signIn(
                                        emailController,
                                        passwordController,
                                        context,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      minimumSize: Size(size.width, 45),

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
                                          "SIGN IN",
                                          style: GoogleFonts.urbanist(
                                            color: Colors.white70,
                                            fontSize: 16,
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
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        height: 0.3,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Or Continue With",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        height: 0.3,
                                        width: double.infinity,
                                        color: Colors.white60,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
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
                                    onPressed: () => _firebaseAuthService
                                        .signInWithGoogle(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?  ",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.white54,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    emailFocus.unfocus();
                                    passwordFocus.unfocus();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.urbanist(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
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
              ValueListenableBuilder(
                valueListenable: _firebaseAuthService.isLoading,
                builder: (context, loading, child) {
                  return loading
                      ? Container(
                          height: size.height,
                          width: size.width,
                          color: Colors.black.withValues(alpha: 0.6),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepOrange,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),
                        )
                      : SizedBox();
                },
              ),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          color: Color.fromRGBO(29, 29, 29, 0.491),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Colors.white38, width: 0.2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(icon, color: Colors.white54, size: 25),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscure,
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                focusNode: focusNode,
                onSubmitted: (value) {
                  if (emailFocus.hasFocus) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  } else {
                    _firebaseAuthService.signIn(
                      emailController,
                      passwordController,
                      context,
                    );
                  }
                },
                cursorColor: Colors.deepOrange.withValues(alpha: 0.6),

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: GoogleFonts.urbanist(
                    color: Colors.white70,
                    fontSize: 14,
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
