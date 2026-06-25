import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class PrivateAuthService extends StatefulWidget {
  const PrivateAuthService({super.key});

  @override
  State<PrivateAuthService> createState() => _PrivateAuthServiceState();
}

class _PrivateAuthServiceState extends State<PrivateAuthService> {
  final LocalAuthentication auth = LocalAuthentication();
  final String pin = "1234";
  final TextEditingController controller = TextEditingController();
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
        body: Column(children: [
          SizedBox(height: 100,),
          Image.asset(
                            "assets/images/private_auth.png",
                            width: size.width,
                            height: 250,
                          ),
        ],),
    ));
  }
}
