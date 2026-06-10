import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/services/secure_storage_service.dart';
import 'package:overcloud/utils/error_dialog.dart';
import 'package:overcloud/screens/home_page.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final String _webSdkClientId =
      "725343694902-ok4rab3baj2u0k1efvtkqleqes5jaej7.apps.googleusercontent.com";
      

  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();

  late String uid = _auth.currentUser!.uid;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> signIn(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await _firestoreService.storeUserDetails(uid);

      if (!context.mounted) return;
      isLoading.value = false;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      isLoading.value = false;
      if (emailController.text.trim().isEmpty &&
          passwordController.text.trim().isEmpty) {
        errorMessage(
          "Credentials are required",
          "Please enter your email id and password",
          context,
        );
      } else if (emailController.text.trim().isEmpty) {
        errorMessage(
          "Email is required",
          "Please enter your email id.",
          context,
        );
      } else if (passwordController.text.trim().isEmpty) {
        errorMessage(
          "Password is required",
          "Please enter your password.",
          context,
        );
      } else if (e.code == "invalid-email") {
        errorMessage(
          "Invalid Email Format",
          "The email id is badly formatted.",
          context,
        );
      } else if (e.code == "invalid-credential") {
        errorMessage(
          "Invalid Email/Password",
          "Please enter correct email or password",
          context,
        );
      } else if (e.code == "user-disabled") {
        errorMessage(
          "Account Disabled",
          "This user account has been disabled.",
          context,
        );
      } else if (e.code == "too-many-requests") {
        errorMessage(
          "Too Many Requests",
          "Too many unsuccessful login attempts. Please try again later.",
          context,
        );
      } else {
        errorMessage(
          "Login Error",
          e.message ?? "An unknown error occurred.",
          context,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    isLoading.value = true;
    try {

      await _googleSignIn.initialize(serverClientId: _webSdkClientId);

      final GoogleSignInAccount userAccount = await _googleSignIn
          .authenticate();

          

      final GoogleSignInAuthentication googleAuth = userAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

    

      final userCredentials = await _auth.signInWithCredential(credentials);

      await SecureStorageService.setFullName(
        _auth.currentUser!.displayName.toString(),
      );
      await SecureStorageService.setEmail(_auth.currentUser!.email.toString());
      await SecureStorageService.setUID(_auth.currentUser!.uid.toString());



      String uid = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "fullName": userCredentials.user!.displayName.toString(),
        "phoneNumber": userCredentials.user!.phoneNumber.toString(),
        "email": userCredentials.user!.email.toString(),
      });

      _firestoreService.createDefaultFolders(uid,"photos");
      _firestoreService.createDefaultFolders(uid,"documents");
      _firestoreService.createDefaultFolders(uid,"videos");
      _firestoreService.createDefaultFolders(uid,"music");

      if (!context.mounted) return;

      isLoading.value = false;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }  catch (e, stackTrace) {
  debugPrint("Google Sign In Error: $e");
  debugPrintStack(stackTrace: stackTrace);
  rethrow;
} finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    BuildContext context,
  ) async {
    isLoading.value = true;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "fullName": nameController.text.trim(),
        "phoneNumber": "+91${phoneController.text.trim()}",
        "email": emailController.text.trim(),
      });

      await _firestoreService.storeUserDetails(uid);

      if (!context.mounted) return;

      isLoading.value = false;

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseException catch (e) {
      isLoading.value = false;
      debugPrint(e.code);
      if (nameController.text.trim().isEmpty &&
          emailController.text.trim().isEmpty &&
          passwordController.text.trim().isEmpty &&
          confirmPasswordController.text.trim().isEmpty) {
        errorMessage(
          "Required field are empty",
          "Please fill all the mandatory fields.",
          context,
        );
      } else if (emailController.text.trim().isEmpty) {
        errorMessage(
          "Email is required",
          "Please enter your email id.",
          context,
        );
      } else if (passwordController.text.trim().isEmpty) {
        errorMessage(
          "Password is required",
          "Please enter your password.",
          context,
        );
      } else if (e.code == "invalid-email") {
        errorMessage(
          "Invalid Email Format",
          "The email id is badly formatted.",
          context,
        );
      } else if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        errorMessage(
          "Passwords Do Not Match",
          "The password and confirmation password must be the same.",
          context,
        );
      } else if (e.code == "email-already-in-use") {
        errorMessage(
          "Email Already Exists",
          "The email id is already in use by another account.",
          context,
        );
      } else if (e.code == "too-many-requests") {
        errorMessage(
          "Too Many Requests",
          "Too many unsuccessful login attempts. Please try again later.",
          context,
        );
      } else {
        errorMessage(
          "Sign up Error",
          e.message ?? "An unknown error occurred.",
          context,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    await _auth.signOut();
    await GoogleSignIn.instance.signOut();
    await SecureStorageService.clearStorageData();
    isLoading.value = false;
  }
}
