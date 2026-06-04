import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overcloud/helper/error_dialog.dart';
import 'package:overcloud/screens/home_page.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

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
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "fullName": nameController.text.trim(),
        "phoneNumber": "+91${phoneController.text.trim()}",
        "email": emailController.text.trim(),
      });

      if (!context.mounted) return;

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseException catch (e) {
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
    }
  }
}
