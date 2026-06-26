import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overcloud/utils/error_dialog.dart';
import 'package:pinput/pinput.dart';

class PrivateAuthService extends StatefulWidget {
  final String folderName;
  final String folderId;
  const PrivateAuthService({super.key, required this.folderName, required this.folderId});

  @override
  State<PrivateAuthService> createState() => _PrivateAuthServiceState();
}

class _PrivateAuthServiceState extends State<PrivateAuthService> {
  final LocalAuthentication auth = LocalAuthentication();
  final String pin = "1234";
  final TextEditingController uPIN = TextEditingController(text: "");
  bool isBiometricAvailable = false;
  bool isLoading = false;

  @override
  void initState() {
    _checkBiometricAvailability();
    super.initState();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      bool isAvailable = await auth.canCheckBiometrics;
      setState(() {
        isBiometricAvailable = isAvailable;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _pinAuthentication() async {}

  Future<void> _biometricAuthentication() async {
    if (!isBiometricAvailable) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      bool authenticate = await auth.authenticate(
        localizedReason: "login Via Biometrics",
        biometricOnly: true,
      );

      if (authenticate) {
        print("authentication completed");
      }
    } on LocalAuthException catch (e) {
      switch (e.code) {
        case LocalAuthExceptionCode.temporaryLockout:
        case LocalAuthExceptionCode.biometricLockout:
          errorMessage(
            "Too Many Failed Attempts",
            "Please try again in a moment.",
            context,
          );
          print("Too many failed attempts. Please try again in a moment.");
          break;

        case LocalAuthExceptionCode.noBiometricsEnrolled:
          // Some devices incorrectly return this during a temporary lockout.
          errorMessage(
            "Biometrics Locked",
            "Please try again in a few moments.",
            context,
          );
          break;

        default:
          print("Authentication failed.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(15, 15, 15, 1),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Stack(
              children: [
                Image.asset(
                  "assets/images/pri6.png",
                  width: size.width,
                  height: 200,
                ),
              ],
            ),
            Text(
              "PRIVATE FOLDER",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Your files. Your Privacy. Protected.",
                maxLines: 2,
                style: GoogleFonts.urbanist(
                  color: Colors.white60,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            Container(
              width: 200,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(25, 25, 25, 0.95),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(25, 25, 25, 0.945),
                    Color.fromRGBO(19, 19, 19, 0.949),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Text(
                    "Enter your PIN",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: uPIN.text.length >= 1
                            ? Colors.deepOrange
                            : Colors.white54,
                        size: 20,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.circle_outlined,
                        color: uPIN.text.length >= 2
                            ? Colors.deepOrange
                            : Colors.white54,
                        size: 20,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.circle_outlined,
                        color: uPIN.text.length >= 3
                            ? Colors.deepOrange
                            : Colors.white54,
                        size: 20,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.circle_outlined,
                        color: uPIN.text.length == 4
                            ? Colors.deepOrange
                            : Colors.white54,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            numberKeypad(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget numberKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            singleNumberContainer("1"),
            SizedBox(width: 40),
            singleNumberContainer("2"),
            SizedBox(width: 40),
            singleNumberContainer("3"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            singleNumberContainer("4"),
            SizedBox(width: 40),
            singleNumberContainer("5"),
            SizedBox(width: 40),
            singleNumberContainer("6"),
          ],
        ),

        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            singleNumberContainer("7"),
            SizedBox(width: 40),
            singleNumberContainer("8"),
            SizedBox(width: 40),
            singleNumberContainer("9"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _biometricAuthentication(),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(24, 24, 24, 0.941),
                  border: Border.all(
                    color: Colors.deepOrange.withValues(alpha: 0.9),
                    width: 0.5,
                  ),

                  // border: BorderDirectional(top: BorderSide(color: Colors.deepOrange,width: ),),
                ),
                child: Center(
                  child: Icon(
                    Icons.fingerprint,
                    color: Colors.deepOrange.withValues(alpha: 0.9),
                    size: 35,
                  ),
                ),
              ),
            ),
            SizedBox(width: 40),
            singleNumberContainer("0"),

            SizedBox(width: 40),
            GestureDetector(
              onTap: () {
                uPIN.delete();
                print("pinnnnn: ${uPIN.text}");
                setState(() {});
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(24, 24, 24, 0.941),

                  border: BorderDirectional(
                    top: BorderSide(color: Colors.white10, width: 2),
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.deleteLeft,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget singleNumberContainer(String number) {
    return GestureDetector(
      onTap: () {
        if (uPIN.text.length < 4) {
          uPIN.text = uPIN.text + number;
        }

        setState(() {});

        print("pinnnnn: ${uPIN.text}");
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(24, 24, 24, 0.941),

          border: BorderDirectional(
            top: BorderSide(color: Colors.white10, width: 2),
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.urbanist(
              color: Colors.white70,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
