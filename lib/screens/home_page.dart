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
                      FontAwesomeIcons.bell,
                      color: Colors.white,
                    ),
                    activeItem: FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: Colors.white,
                    ),
                    itemLabel: 'Updates',
                  ),

                  BottomBarItem(
                    inActiveItem: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    activeItem: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white,
                    ),
                    itemLabel: 'Upload',
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
            "Good Morning ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 16),
          ),
          FaIcon(FontAwesomeIcons.sun, color: Colors.deepOrange),
        ],
      );
    } else if (hour < 17) {
      return Row(
        children: [
          Text(
            "Good Afternoon ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 16),
          ),
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            "Good Evening ",
            style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 16),
          ),
          FaIcon(FontAwesomeIcons.cloudSun, color: Colors.deepOrange),
        ],
      );
    }
  }

  Widget InitialsAvatar() {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.deepOrange,
      child: Text(
        "VP",
        style: GoogleFonts.robotoMono(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  greetingText(),
                  Text(
                    'User Name',
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InitialsAvatar(),
            ],
          ),
          const SizedBox(height: 50),

          Container(
            height: 180,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.deepOrange.withOpacity(0.3),
                width: 1.2,
              ),

              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromRGBO(255, 120, 0, 0.05),
                  Color.fromRGBO(255, 104, 0, 0.4),
                ],
              ),

              // boxShadow: [
              //   BoxShadow(
              //     color: Color.fromRGBO(255, 120, 0, 0.),
              //     blurRadius: 20,
              //     spreadRadius: 1,
              //     offset: Offset(0, 8),
              //   ),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CLOUD STORAGE",
                        style: GoogleFonts.robotoMono(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          fontSize: 18,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.infinity,
                        color: Colors.deepOrange,
                        size: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "75% Used",
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.white10,
                      color: Colors.deepOrange,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "128 GB / 256 GB",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                infoChips(Color.fromRGBO(255, 104, 0, 1), "Photos"),
                SizedBox(width: 10,),
                infoChips(Color.fromRGBO(255, 218, 91, 1.0), "Docs"),
                SizedBox(width: 10,),
                infoChips(Color.fromRGBO(241, 90, 90, 1.0), "Videos"),
                SizedBox(width: 10,),
                infoChips(Color.fromRGBO(50, 218, 150, 1.0), "Audio")
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              quickAccess("1.2K","FILES",FontAwesomeIcons.solidFolderOpen,const Color.fromRGBO(255, 196, 87, 1)),
              quickAccess("24","PRIVATE",FontAwesomeIcons.shieldHalved, const Color.fromRGBO(255, 120, 80, 1)),
              quickAccess("87","STARRED",FontAwesomeIcons.solidStar ,const Color.fromRGBO(255, 170, 60, 1)),
            ],
          ),




        ],
      ),
    );
  }
}

Widget quickAccess(String title, String subTitle, FaIconData icon, Color iconColor){
  return Container(
    height: 120,
    width: 100,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white24),
      color: Color.fromRGBO(40, 40, 40, 0.7),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon,color: iconColor,size: 28,),
        SizedBox(height: 10,),
        Text(
          title,
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),Text(
          subTitle,
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 12,

          ),
        ),

      ],
    ),
  );
}

Widget infoChips(Color color, String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    height: 38,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: color.withOpacity(0.4)),
      color: color.withOpacity(0.2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(FontAwesomeIcons.solidCircle, color: color, size: 10),
        SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.urbanist(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
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
