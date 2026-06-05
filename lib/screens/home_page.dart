import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_auth_service.dart';
import 'package:overcloud/screens/files_content.dart';
import 'package:overcloud/screens/home_content.dart';
import 'package:overcloud/screens/login/sign_in_page.dart';
import 'package:overcloud/screens/uploads_content.dart';
import 'package:overcloud/services/secure_storage_service.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      HomeContent(controller: _controller),
      FilesContent(controller: _controller),
      UploadsContent(controller: _controller),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(15, 15, 15, 1),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Color.fromRGBO(15, 15, 15, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () async {
                  await SecureStorageService.clearStorageData();
                 await  FirebaseAuthService().signOut();

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInPage()));

                }, child: Text("Sign Out")),
              ],
            ),
          ),
        ),
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
