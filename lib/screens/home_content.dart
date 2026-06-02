import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContent extends StatelessWidget {
  final NotchBottomBarController? controller;

  const HomeContent({super.key, this.controller});

  Widget greetingText() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Row(
        children: [
          Text(
            "GOOD MORNING  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1),
          ),
          FaIcon(FontAwesomeIcons.sun, color: Colors.deepOrange, size: 20),
        ],
      );
    } else if (hour < 17) {
      return Row(
        children: [
          Text(
            "GOOD AFTERNOON  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1)),
          
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange, size: 20),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            "GOOD EVENING  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.w500,letterSpacing: 1),
          ),
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange, size: 20),
        ],
      );
    }
  }

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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Color.fromRGBO(15, 15, 15, 1)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      greetingText(),
                      SizedBox(height: 5),
                      Text(
                        'Vishant Pasi',
                        style: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  initialsAvatar(),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        ),
                      ),
                      child: TextField(
                        style: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          isDense: true,

                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          hintText: "Search your files, folders...",
                          hintStyle: GoogleFonts.urbanist(
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.white38),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,

                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(40, 40, 40, 1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.bell,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                height: 150,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),

                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(255, 119, 40, 0.889),
                      Color.fromRGBO(210, 75, 10, 1),
                      Color.fromRGBO(120, 35, 0, 1),
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 98, 0, 0.35),
                      blurRadius: 35,
                      spreadRadius: 3,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CLOUD STORAGE",
                            style: GoogleFonts.urbanist(
                              color: Color.fromRGBO(255, 230, 210, 0.8),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 6,
                              fontSize: 14,
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.infinity,
                            color: Color.fromRGBO(255, 230, 210, 0.7),
                            size: 25,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "75.4 GB Used",
                        style: GoogleFonts.urbanist(
                          color: Color.fromRGBO(255, 250, 245, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          FractionallySizedBox(
                            widthFactor: 0.3,
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(255, 234, 193, 1),
                                    Color.fromRGBO(255, 171, 98, 1),
                                    Color.fromRGBO(255, 128, 0, 1),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(255, 120, 30, 0.5),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    infoChips(
                      Colors.deepOrange,
                      "Photos",
                      FontAwesomeIcons.photoFilm,

                      "120",
                    ),
                    SizedBox(width: 10),
                    infoChips(
                      const Color.fromRGBO(255, 196, 87, 1),
                      "Docs",
                      FontAwesomeIcons.solidFileLines,

                      "45",
                    ),
                    SizedBox(width: 10),
                    infoChips(
                      const Color.fromARGB(255, 244, 54, 92),
                      "Videos",
                      FontAwesomeIcons.solidCirclePlay,

                      "23",
                    ),
                    SizedBox(width: 10),
                    infoChips(
                      const Color.fromARGB(226, 64, 251, 189),
                      "Audio",
                      FontAwesomeIcons.music,

                      "15",
                    ),
                    SizedBox(width: 10),
                    infoChips(
                      const Color.fromARGB(255, 64, 170, 251),
                      "More",
                      FontAwesomeIcons.ellipsis,

                      "",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "QUICK ACCESS",
                style: GoogleFonts.urbanist(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  quickAccess(
                    "1.2K",
                    "Files",

                    FontAwesomeIcons.solidFolderOpen,
                    const Color.fromRGBO(255, 196, 87, 1),
                  ),
                  quickAccess(
                    "24",
                    "Private",

                    FontAwesomeIcons.userLock,
                    const Color.fromRGBO(255, 120, 80, 1),
                  ),
                  quickAccess(
                    "87",
                    "Starred",

                    FontAwesomeIcons.solidStar,
                    const Color.fromRGBO(255, 170, 60, 1),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                        "RECENT FILES",
                        style: GoogleFonts.urbanist(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3
                        ),
                      ),
                  Text(
                    "View All",
                    style: GoogleFonts.urbanist(
                      color: Colors.deepOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                width: size.width,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 25, 25, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "No recent files",
                    style: GoogleFonts.urbanist(
                      color: Colors.white38,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

Widget quickAccess(
  String title,
  String subTitle,
  FaIconData icon,
  Color iconColor,
) {
  return Expanded(
    child: Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromRGBO(45, 45, 45, 0.95),
            const Color.fromRGBO(25, 25, 25, 0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(child: FaIcon(icon, color: iconColor, size: 18)),
              ),

              FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white30,
                size: 12,
              ),
            ],
          ),

          const Spacer(),

          Text(
            title,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subTitle,
            style: GoogleFonts.urbanist(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget infoChips(Color color, String text, FaIconData icon, String subText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
    width: 75,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white24, width: 0.5),

      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.125),
          color.withValues(alpha: 0.020),
          Color.fromRGBO(40, 40, 40, 1).withValues(alpha: 0.110),
        ],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, color: color, size: 23),
        SizedBox(height: 8),
        Text(
          text,
          style: GoogleFonts.urbanist(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          subText,
          style: GoogleFonts.urbanist(
            color: Colors.white60,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
