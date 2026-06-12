import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';

Future<String?> renameFileBottomSheet(
  BuildContext context,
  String uid,
  String folderId,
  String fileId,
  String fileName,
) async {
  final TextEditingController folderController = TextEditingController(
    text: fileName,
  );

  final FirebaseFirestoreService firestore = FirebaseFirestoreService();

  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            const Icon(
              Icons.drive_file_rename_outline_rounded,
              size: 60,
              color: Colors.deepOrange,
            ),

            const SizedBox(height: 15),

            Text(
              "Rename File",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Enter a new name for your file",
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: folderController,
              autofocus: true,
              cursorColor: Colors.deepOrange,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "File Name",
                hintStyle: GoogleFonts.urbanist(color: Colors.white38),
                filled: true,
                fillColor: const Color.fromRGBO(40, 40, 40, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  final newFileName = folderController.text.trim();

                  if (newFileName.isEmpty || newFileName == fileName) {
                    Navigator.pop(context);
                    return;
                  }

                  firestore.renameFileName(uid, folderId, fileId, newFileName);

                  Navigator.pop(context, newFileName);
                },
                icon: const Icon(Icons.edit_rounded, color: Colors.white),
                label: Text(
                  "Rename File",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
