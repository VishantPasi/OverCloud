import 'dart:ui';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/screens/home_content.dart';

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
      FilesContent(controller: _controller),
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
            ? Container(
                color: Colors.transparent,
                child: AnimatedNotchBottomBar(
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
                ),
              )
            : null,
      ),
    );
  }
}

class FilesContent extends StatefulWidget {
  final NotchBottomBarController? controller;

  const FilesContent({Key? key, this.controller}) : super(key: key);

  @override
  State<FilesContent> createState() => _FilesContentState();
}

class _FilesContentState extends State<FilesContent> {

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Files",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                initialsAvatar()
              ],
            ),
            SizedBox(height: 30),
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
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "FOLDERS",
                      style: GoogleFonts.urbanist(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3
                      ),
                    ),
                    Text(
                      "filter",
                      style: GoogleFonts.urbanist(
                        color: Colors.white38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
          ],
        ),
      ),
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
