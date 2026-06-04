import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void errorMessage(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        constraints: BoxConstraints(minWidth: 300),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "assets/animations/error.json",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: GoogleFonts.urbanist(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
