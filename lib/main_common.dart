import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overcloud/env_config.dart';
import 'package:overcloud/screens/login/sign_in_page.dart';
import 'package:overcloud/services/private_auth_service.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint(
    "----------------------  Environment: ${AppEnvironment.environmentName}  ----------------------",
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'OverCloud',
      home: SignInPage(),
      // home: PrivateAuthService()
    );
  }
}
