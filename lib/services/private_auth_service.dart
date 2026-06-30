import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/screens/folders_page.dart';
import 'package:overcloud/screens/private_folder_page.dart';
import 'package:overcloud/services/secure_storage_service.dart';
import 'package:overcloud/utils/error_dialog.dart';
import 'package:pinput/pinput.dart';

class PrivateAuthService extends StatefulWidget {
  final String uid;
  final bool isPFEnabled;
  final String folderName;
  final String folderId;
  const PrivateAuthService({
    super.key,
    required this.uid,
    required this.isPFEnabled,
    required this.folderName,
    required this.folderId,
  });

  @override
  State<PrivateAuthService> createState() => _PrivateAuthServiceState();
}

class _PrivateAuthServiceState extends State<PrivateAuthService> {
  final LocalAuthentication auth = LocalAuthentication();
  late String pin;
  final TextEditingController uPIN = TextEditingController(text: "");
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  bool isBiometricAvailable = false;
  bool isLoading = false;
  int failedAttempts = 0;
  DateTime? lockUntil;
  bool isLocked = false;
  int remainingSeconds = 30;

  Timer? _lockTimer;

  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  void startLockTimer() {
    _lockTimer?.cancel();

    _lockTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final millis = int.parse(
        await SecureStorageService.getLockUntil() ?? "0",
      );

      final seconds = DateTime.fromMillisecondsSinceEpoch(
        millis,
      ).difference(DateTime.now()).inSeconds;

      if (seconds <= 0) {
        timer.cancel();

        await SecureStorageService.clearLockTimer();

        setState(() {
          isLocked = false;
          failedAttempts = 0;
          remainingSeconds = 0;
        });
      } else {
        setState(() {
          remainingSeconds = seconds;
        });
      }
    });
  }

  @override
  void initState() {
    _initialize();

    super.initState();
  }

  Future<void> _initialize() async {
    final millis = int.parse(await SecureStorageService.getLockUntil() ?? "0");

    print(millis);

    if (millis != null) {
      final endTime = DateTime.fromMillisecondsSinceEpoch(millis);

      if (DateTime.now().isBefore(endTime)) {
        isLocked = true;
        remainingSeconds = endTime.difference(DateTime.now()).inSeconds;

        startLockTimer();
      }
    }

    if (widget.isPFEnabled) {
      uPIN.addListener(_pinListener);
    }

    _firestore.getPrivateFolderPin(widget.uid).listen((str) {
      pin = str;
    });
  }

  @override
  void dispose() {
    _lockTimer?.cancel();
    uPIN.removeListener(_pinListener);
    uPIN.dispose();
    super.dispose();
  }

  void _pinListener() {
    setState(() {});

    if (uPIN.text.length == 4) {
      _pinAuthentication();
    }
  }

  // Future<void> _checkBiometricAvailability() async {
  //   try {
  //     bool isAvailable = await auth.canCheckBiometrics;
  //     setState(() {
  //       isBiometricAvailable = isAvailable;
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> _pinAuthentication() async {
    if (isLocked) return;

    if (uPIN.text == pin) {
      failedAttempts = 0;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PrivateFolderPage(
            folderName: widget.folderName,
            folderId: widget.folderId,
          ),
        ),
      );
    } else {
      failedAttempts++;

      uPIN.clear();

      if (failedAttempts >= 3) {
        final endTime = DateTime.now().add(const Duration(seconds: 30));

        await SecureStorageService.setLockUntil(endTime.millisecondsSinceEpoch);

        setState(() {
          isLocked = true;
          remainingSeconds = 30;
        });

        startLockTimer();
      } else {
        errorMessage(
          "Invalid PIN",
          "Please enter the correct PIN.\n${3 - failedAttempts} attempt(s) remaining.",
          context,
        );
      }

      setState(() {});
    }
  }

  Future<void> _biometricAuthentication() async {
    if (isLocked) {
      return;
    }

    final canCheckBiometrics = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    final availableBiometrics = await auth.getAvailableBiometrics();

    if (!isDeviceSupported || !canCheckBiometrics) {
      errorMessage(
        "Biometrics Unavailable",
        "This device doesn't support biometric authentication.",
        context,
      );
      return;
    }

    if (availableBiometrics.isEmpty) {
      errorMessage(
        "No Biometrics Found",
        "Set up a fingerprint or face recognition in your device settings.",
        context,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      bool authenticate = await auth.authenticate(
        localizedReason: "Authenticate to access your Private Folder",
        biometricOnly: true,
      );

      if (authenticate) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PrivateFolderPage(
              folderName: widget.folderName,
              folderId: widget.folderId,
            ),
          ),
        );
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
              widget.isPFEnabled ? "PRIVATE FOLDER" : "SETUP PRIVATE FOLDER",
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
                widget.isPFEnabled
                    ? "Your files. Your privacy. Protected."
                    : "Create a secure 4-digit PIN to protect your private files.",
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
              width: widget.isPFEnabled ? 230 : 250,
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
                    isLocked
                        ? "Try again in $remainingSeconds seconds"
                        : widget.isPFEnabled
                        ? "ENTER YOUR PIN"
                        : "CREATE A 4-DIGIT PIN",
                    style: GoogleFonts.urbanist(
                      color: isLocked ? Colors.deepOrange : Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 20),
                  widget.isPFEnabled
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Icon(
                                Icons.circle_outlined,
                                color: uPIN.text.length > index
                                    ? Colors.deepOrange
                                    : Colors.white54,
                                size: 20,
                              ),
                            );
                          }),
                        )
                      : Pinput(
                          controller: uPIN,
                          length: 4,
                          autofocus: true,
                          readOnly: true, // Since you're using your own keypad
                          defaultPinTheme: PinTheme(
                            width: 55,
                            height: 55,
                            textStyle: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(24, 24, 24, 1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white10),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 45,
                            height: 55,
                            textStyle: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(24, 24, 24, 1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.deepOrange),
                            ),
                          ),
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
            // Left Button
            GestureDetector(
              onTap: () {
                if (widget.isPFEnabled) {
                  _biometricAuthentication();
                } else {
                  uPIN.delete();
                  setState(() {});
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(24, 24, 24, 0.941),
                  border: Border.all(
                    color: widget.isPFEnabled
                        ? Colors.deepOrange.withValues(alpha: .9)
                        : Colors.white10,
                    width: widget.isPFEnabled ? .5 : 2,
                  ),
                ),
                child: Center(
                  child: widget.isPFEnabled
                      ? Icon(
                          Icons.fingerprint,
                          color: Colors.deepOrange.withValues(alpha: .9),
                          size: 35,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.deleteLeft,
                          color: Colors.white60,
                        ),
                ),
              ),
            ),

            const SizedBox(width: 40),

            singleNumberContainer("0"),

            const SizedBox(width: 40),

            // Right Button
            GestureDetector(
              onTap: () {
                if (widget.isPFEnabled) {
                  uPIN.delete();
                  setState(() {});
                } else {
                  if (uPIN.text.length == 4) {
                    _firestoreService.updatePFDetails(widget.uid, uPIN.text);
                    setState(() {});

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivateFolderPage(
                          folderName: widget.folderName,
                          folderId: widget.folderId,
                        ),
                      ),
                    );
                  } else {
                    errorMessage(
                      "Complete PIN Required",
                      "Enter your 4-digit PIN to continue.",
                      context,
                    );
                  }
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(24, 24, 24, 0.941),
                  border: const BorderDirectional(
                    top: BorderSide(color: Colors.white10, width: 2),
                  ),
                ),
                child: Center(
                  child: widget.isPFEnabled
                      ? const FaIcon(
                          FontAwesomeIcons.deleteLeft,
                          color: Colors.white60,
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.deepOrange,
                          size: 30,
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
        if (isLocked) return;
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
