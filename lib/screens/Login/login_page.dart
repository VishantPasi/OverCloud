import 'package:flutter/material.dart';
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
        children: [

          Stack(
            children: [
              Transform.translate(offset: const Offset(40,-40),child: Image.asset("assets/images/background_login3.png", width: 500,height: 400,)),

              Positioned(
                top: 70,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Step Into,",style: GoogleFonts.playfairDisplay(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                    Text("OverCloud",style: GoogleFonts.playfairDisplay(color: Colors.deepOrange,fontSize: 35,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("The Cloud, Reimagined",style: GoogleFonts.urbanist(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 50,),


                    

                  ],
                ),
              )


            ],


          )
          ,
          // Container(width: width,height:10, color: Colors.white,),
          customTextField(hint: "Email", icon: Icons.email, controller: emailController),
          const SizedBox(height: 16),
          customTextField(hint: "Password", icon: Icons.lock, controller: passwordController),
          const SizedBox(height: 24),

        ],
      ),

    );
  }

  customTextField( {
    String? hint,
    IconData? icon,
    TextEditingController? controller
}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        style: GoogleFonts.urbanist(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: hint,
          hintStyle: GoogleFonts.urbanist(color: Colors.white54),
          prefixIcon: icon != null ? Icon(icon, color: Colors.white54) : null,
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}