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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscure = true;
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
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

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Container(
          //     height: 110,
          //     width: width,
          //     decoration: BoxDecoration(
          //       color: Color.fromRGBO(29, 29, 29, 0.8235294117647058),
          //       boxShadow: [
          //         BoxShadow(
          //           blurStyle: BlurStyle.outer,
          //           color: Colors.black.withOpacity(0.3),
          //
          //           blurRadius: 10,
          //         ),
          //       ],
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 15.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           SizedBox(),
          //           InfoTabs(Icons.cloud_done_outlined, 35, "Secure"),
          //           VerticalDivider(
          //             color: Colors.white38,
          //             thickness: 0.5,
          //             width: 20,
          //           ),
          //           InfoTabs(Icons.widgets_outlined, 28, "Scalable"),
          //           VerticalDivider(
          //             color: Colors.white38,
          //             thickness: 0.5,
          //             width: 20,
          //           ),
          //           InfoTabs(Icons.bolt_outlined, 32, "Fast"),
          //           VerticalDivider(
          //             color: Colors.white38,
          //             thickness: 0.5,
          //             width: 20,
          //           ),
          //           InfoTabs(Icons.verified_user_outlined, 30, "Reliable"),
          //           SizedBox(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: width,
              height: 400,

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                color: Color.fromRGBO(29, 29, 29, 0.8235294117647058),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Sign In to Continue to OverCloud",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        color: Colors.white54,

                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  customTextField(
                    "Email",
                    emailController,
                    false,
                    Icons.email_outlined,
                  ),
                  SizedBox(height: 20),
                  customTextField(
                    "Password",
                    passwordController,
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
                          colors: [
                            Color(0xFFFF7A00),
                            Color(0xFFFF3D00),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                                            ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(width, 45),


                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              "Sign In",
                              style: GoogleFonts.urbanist(
                                color: Colors.white70,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            FaIcon(FontAwesomeIcons.arrowRight,color: Colors.white70,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(height: 0.5,color: Colors.white60,),
                      )),
                      Text("Or Continue With",style: GoogleFonts.urbanist(color: Colors.white70),),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(height: 0.5,width: double.infinity,color: Colors.white60,),
                      )),
                    ],),
                  )


                ],
              ),
            ),
          ),

        ],
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
