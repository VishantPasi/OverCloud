import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

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
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              setState(() {
                nameFocus.unfocus();
                phoneFocus.unfocus();
                emailFocus.unfocus();
                passwordFocus.unfocus();
                confirmPasswordFocus.unfocus();
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 290,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/background_signup.png",
                        width: width,
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
                              "Beyond Storage.",
                              style: GoogleFonts.urbanist(
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withValues(alpha: 0.8),
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
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 123, 41, 1),
                                  Color.fromRGBO(205, 70, 22, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                "Beyond Limits.",
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
                              "The Cloud. Perfected.",
                              style: GoogleFonts.urbanist(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 1),
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
                              "Manage, sync, and\nscale effortlessly.",
                              style: GoogleFonts.urbanist(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.5),
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

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "STORE",
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
                      "SYNC",
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
                      "ACCESS",
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: width,
                  
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.05),
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
                              Text(
                                "Create Your Account",
                                style: GoogleFonts.urbanist(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                  
                              SizedBox(height: 5),
                              Text(
                                "Get started with your OverCloud Account",
                                maxLines: 2,
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
                          "Full Name",
                          "Enter your full name",
                          nameController,
                          nameFocus,
                          Icons.person_outline,
                          true,
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          "Phone Number",
                          "Enter your phone number",
                          phoneController,
                          phoneFocus,
                          Icons.phone_outlined,
                          false,
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          "Email Address",
                          "Enter your email",
                          emailController,
                          emailFocus,
                          Icons.email_outlined,
                          true,
                        ),
                        SizedBox(height: 20),
                  
                        customTextField(
                          "Password",
                          "Enter your password",
                          passwordController,
                          passwordFocus,
                          Icons.lock_outline,
                          true,
                        ),
                        SizedBox(height: 20),
                  
                        customTextField(
                          "Confirm Password",
                          "Enter your confirm password",
                          confirmPasswordController,
                          confirmPasswordFocus,
                          Icons.verified_user_outlined,
                          true,
                        ),
                        SizedBox(height: 50),
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
                                onPressed: () {},
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
                                      "Create Account",
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
                        SizedBox(height: 35),
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
                                  color: Colors.black.withValues(alpha: 0.4),
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
                      ),
                  
                  SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?  ",
                            style: GoogleFonts.urbanist(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
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
        ),
      ),
    );
  }

  Widget customTextField(
    String title,
    String hint,
    TextEditingController controller,
    FocusNode focusNode,
    IconData icon,
    bool isRequired,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.urbanist(
                  color: Colors.white54,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isRequired
                  ? Text(
                      " *",
                      style: GoogleFonts.urbanist(
                        color: Colors.deepOrange.withValues(alpha: 0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white38, width: 0.2),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    icon,
                    color: Colors.white54,
                    size: 25,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    keyboardType: controller == phoneController
                        ? TextInputType.phone
                        : TextInputType.text,
                    inputFormatters: controller == phoneController
                        ? [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ]
                        : [],
                    focusNode: focusNode,
                    onSubmitted: (value) {
                      if (emailFocus.hasFocus) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      } else {}
                    },
                    cursorColor: Colors.deepOrange.withValues(alpha: 0.6),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: GoogleFonts.urbanist(
                        color: Colors.white38,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
