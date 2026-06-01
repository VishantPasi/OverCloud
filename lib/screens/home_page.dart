import 'dart:ui';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);

  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomeContent(controller: _controller),
      const Page2(),
      const Page3(),
      const Page4(),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(15, 15, 15, 1),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),

          children: List.generate(
            bottomBarPages.length,
            (index) => bottomBarPages[index],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,

                bottomBarHeight: 62,
                circleMargin: 3,
                kIconSize: 22,

                showLabel: true,
                showShadow: false,

                color: Color.fromRGBO(40, 40, 40, 1),
                notchColor: Colors.deepOrange,

                itemLabelStyle: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),

                bottomBarItems: const [
                  BottomBarItem(
                    inActiveItem: FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.white,
                    ),
                    activeItem: FaIcon(
                      FontAwesomeIcons.solidHouse,
                      color: Colors.white,
                    ),
                    itemLabel: 'Home',
                  ),

                  BottomBarItem(
                    inActiveItem: FaIcon(
                      FontAwesomeIcons.folder,
                      color: Colors.white,
                    ),
                    activeItem: FaIcon(
                      FontAwesomeIcons.solidFolder,
                      color: Colors.white,
                    ),
                    itemLabel: 'Files',
                  ),

                  BottomBarItem(
                    inActiveItem: FaIcon(
                      FontAwesomeIcons.upload,
                      color: Colors.white,
                    ),
                    activeItem: FaIcon(
                      FontAwesomeIcons.upload,
                      color: Colors.white,
                    ),
                    itemLabel: 'Uploads',
                  ),
                ],

                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                kBottomRadius: 28,
              )
            : null,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final NotchBottomBarController? controller;

  const HomeContent({Key? key, this.controller}) : super(key: key);

  Widget greetingText() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return Row(
        children: [
          Text(
            "Good Morning  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14),
          ),
          FaIcon(FontAwesomeIcons.sun, color: Colors.deepOrange, size: 20),
        ],
      );
    } else if (hour < 17) {
      return Row(
        children: [
          Text(
            "Good Afternoon  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14),
          ),
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange, size: 20),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            "Good Evening  ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 14),
          ),
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange, size: 20),
        ],
      );
    }
  }

  Widget InitialsAvatar() {
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
    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: BoxDecoration(color: Color.fromRGBO(15, 15, 15, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              InitialsAvatar(),
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
                      color: Colors.white.withOpacity(0.2),
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
                    color: Colors.white.withOpacity(0.2),
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
                color: Colors.white.withOpacity(0.05),
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
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                infoChips(Colors.deepOrange, "Photos", FontAwesomeIcons.solidImage, Colors.deepOrangeAccent, "120 Files"),
                SizedBox(width: 15),
                infoChips(const Color.fromRGBO(255, 196, 87, 1), "Docs", FontAwesomeIcons.solidFileLines, Colors.blueAccent, "45 Files"),
                SizedBox(width: 15),
                infoChips(const Color.fromARGB(255, 244, 54, 92), "Videos", FontAwesomeIcons.solidCirclePlay, Colors.greenAccent, "23 Files"),
                SizedBox(width: 15),
                infoChips(const Color.fromARGB(226, 64, 251, 189), "Audio", FontAwesomeIcons.music, Colors.purpleAccent, "15 Files"),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Quick Access",
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              quickAccess(
                "1.2K",
                "FILES",
                FontAwesomeIcons.solidFolderOpen,
                const Color.fromRGBO(255, 196, 87, 1),
              ),
              quickAccess(
                "24",
                "PRIVATE",
                FontAwesomeIcons.userLock,
                const Color.fromRGBO(255, 120, 80, 1),
              ),
              quickAccess(
                "87",
                "STARRED",
                FontAwesomeIcons.solidStar,
                const Color.fromRGBO(255, 170, 60, 1),
              ),
            ],
          ),
          SizedBox(height: 30),

          Text(
            "Recent Files",
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
      height: 120,
      padding: EdgeInsets.symmetric( vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white24, width: 0.5),
        color: Color.fromRGBO(40, 40, 40, 0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: iconColor,
            size: 28,
            
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

Widget infoChips(Color color, String text,FaIconData icon, Color iconColor,String subText) {
  return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white24, width: 0.5),
                    
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withOpacity(0.135),
                       color.withOpacity(0.020),
                        Color.fromRGBO(40, 40, 40, 1).withOpacity(0.110),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        icon,
                        color: color,
                        size: 25,
                      ),
                      SizedBox(height: 8),
                      Text(
                        text,
                        style: GoogleFonts.urbanist(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        subText,
                        style: GoogleFonts.urbanist(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(15, 15, 15, 1),
      child: const Center(child: Text('Files Screen')),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(15, 15, 15, 1),
      child: const Center(child: Text('Notifications')),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(15, 15, 15, 1),
      child: const Center(child: Text('Upload Screen')),
    );
  }
}
