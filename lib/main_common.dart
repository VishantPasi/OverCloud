import 'package:background_downloader/background_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overcloud/env_config.dart';
import 'package:overcloud/screens/login/sign_in_page.dart';
import 'package:overcloud/services/transfer_service.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint(
    "----------------------  Environment: ${AppEnvironment.environmentName}  ----------------------",
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  TransferService.initialize();


  await FileDownloader().permissions.request(
  PermissionType.notifications,
);

  await FileDownloader().configure(
    globalConfig: [
    (Config.requestTimeout, const Duration(hours: 1)),
  ],
  );

  FileDownloader().configureNotification(
    
  running: const TaskNotification(
    '{filename}',
    'Downloading - {progress}',
  ),

  complete: const TaskNotification(
    'Download Complete',
    '{filename}',
  ),

  error: const TaskNotification(
    'Download Failed',
    '{filename}',
  ),

  paused: const TaskNotification(
    'Download Paused',
    '{filename}',
  ),

  canceled: const TaskNotification(
    'Download Cancelled',
    '{filename}',
  ),

  uploadRunning: const TaskNotification(
    '{filename}',
    'Uploading - {progress}',
  ),

  uploadComplete: const TaskNotification(
    'Upload Complete',
    '{filename}',
  ),

  uploadError: const TaskNotification(
    'Upload Failed',
    '{filename}',
  ),

  uploadCanceled: const TaskNotification(
    'Upload Cancelled',
    '{filename}',
  ),



  progressBar: true,
  tapOpensFile: false,
);

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
