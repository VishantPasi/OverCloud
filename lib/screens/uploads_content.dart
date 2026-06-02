import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadsContent extends StatefulWidget {
final NotchBottomBarController? controller;

  const UploadsContent({super.key,this.controller});

  @override
  State<UploadsContent> createState() => _UploadsContentState();
}

class _UploadsContentState extends State<UploadsContent> {

  Widget initialsAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundColor: Colors.deepOrange,
          child: Text(
            "VP",
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromRGBO(15, 15, 15, 1),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(15, 15, 15, 1),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
           SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Uploads",
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  initialsAvatar()
                ],
              ),
              
            ],
          ),
        )),
      );
    
  }
}

