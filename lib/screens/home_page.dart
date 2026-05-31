import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
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
                showLabel: true,
                shadowElevation: 5,
                bottomBarHeight: 80,
                showShadow: false,

                color: const Color.fromRGBO(40, 40, 40, 1),

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
                  debugPrint("index $index");
                  _pageController.jumpToPage(index);
                },
                kIconSize: 24,
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(color: Color.fromRGBO(15, 15, 15, 1)),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Home Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(child: Text('Files Screen')),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(child: Text('Notifications')),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(child: Text('Upload Screen')),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreenAccent,
      child: const Center(child: Text('Page 5')),
    );
  }
}
