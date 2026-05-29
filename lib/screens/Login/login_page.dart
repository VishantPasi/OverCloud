import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF),
      body: Column(
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  height: 110,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        InfoTabs(Icons.cloud_done_outlined, 35, "Secure"),
                        VerticalDivider(
                          color: Colors.white38,

                          thickness: 0.5,
                          width: 20,
                        ),

                        InfoTabs(Icons.widgets_outlined, 28, "Scalable"),
                        VerticalDivider(
                          color: Colors.white38,
                          thickness: 0.5,
                          width: 20,
                        ),
                        InfoTabs(Icons.bolt_outlined, 32, "Fast"),
                        VerticalDivider(
                          color: Colors.white38,
                          thickness: 0.5,
                          width: 20,
                        ),
                        InfoTabs(Icons.verified_user_outlined, 30, "Reliable"),
                        SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: width,
                  height: 300,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       SizedBox(height: 20),
                   
                      Text(
                        "Sign In to Continue to OverCloud",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          color: Colors.white70,

                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField("Email", emailController, false),
                      SizedBox(height: 10),
                      CustomTextField("Password", passwordController, true),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget CustomTextField(String hint, TextEditingController controller, bool obscure) {
    return Padding(
    
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
      
            color: Color(0xFFFFFFF),
            borderRadius: BorderRadius.circular(10),  
            border: Border.all(color: Colors.white38, width: 0.3)
          ),
      
    
    ));
  }

  Widget InfoTabs(IconData? icon, double size, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                color: const Color.fromARGB(195, 255, 86, 34).withOpacity(0.5),
                offset: const Offset(0, 0),
                blurRadius: 15,
              ),
            ],
            // border: Border.all(color: Colors.deepOrange, width: 1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.deepOrange,
              size: size,
              shadows: [
                Shadow(
                  color: const Color.fromARGB(195, 255, 86, 34),
                  offset: Offset(0, 0),
                  blurRadius: 40,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            text,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
