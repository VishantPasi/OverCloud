import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firestore_create_operations.dart';

Future<String?> createFolderBottomSheet(BuildContext context,String uid, String parentId) async {
  final TextEditingController folderController = TextEditingController();
  final FirestoreCreateOperations firestore = FirestoreCreateOperations();

  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
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
              Icons.create_new_folder_rounded,
              size: 60,
              color: Colors.deepOrange,
            ),

            const SizedBox(height: 15),

            Text(
              "Create Folder",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Enter a name for your new folder",
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: folderController,
              autofocus: true,
              cursorColor: Colors.deepOrange,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Folder Name",
                hintStyle: GoogleFonts.urbanist(
                  color: Colors.white38,
                ),
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
                onPressed: () {
                  if(folderController.text.isNotEmpty){
                    firestore.createFolder(uid, parentId, folderController.text.trim(), context);
                  }
                  
                  Navigator.pop(
                    context,
                    folderController.text.trim(),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text(
                  "Create Folder",
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