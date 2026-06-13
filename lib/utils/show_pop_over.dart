import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/utils/rename_file_bottomsheet.dart';
import 'package:overcloud/utils/rename_folder_bottomsheet.dart';
import 'package:popover/popover.dart';

class ShowPopOver {
  FirebaseFirestoreService firestoreService = FirebaseFirestoreService();

  Future<Object?> popOver(
    BuildContext buttonContext,
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? folderName,
    String? fileName,
    String? fileType,
    String? fileSize,
    bool isFolder,
    bool isStarred,
  ) {
    return showPopover(
      context: buttonContext,
      bodyBuilder: (_) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: menuItems(
          context,
          uid,
          folderId,
          fileId,
          folderName,
          fileName,
          fileType,
          fileSize,
          isFolder,
          isStarred,
        ),
      ),
      width: 150,
      height: 210,
      direction: PopoverDirection.bottom,
      radius: 20,
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
    );
  }

  //150, 210

  Widget menuItems(
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? folderName,
    String? fileName,
    String? fileType,
    String? fileSize,
    bool isFolder,
    bool isStarred,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              isFolder
                  ? renameFolderBottomSheet(
                      context,
                      uid,
                      folderId!,
                      folderName!,
                    )
                  : renameFileBottomSheet(
                      context,
                      uid,
                      folderId!,
                      fileId!,
                      fileName!,
                    );
            },
            child: SizedBox(
              height: 40,

              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.white70, size: 23),
                  SizedBox(width: 15),
                  Text(
                    "Rename",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              print(
                "errorr: $folderId, $folderName, $fileId, $fileName, $fileType, $fileSize $isFolder",
              );
              isFolder
                  ? firestoreService.addToStarred(
                      uid,
                      folderId!,
                      folderName,
                      fileId,
                      fileName,
                      fileType,
                      fileSize,
                      true,
                    )
                  : firestoreService.addToStarred(
                      uid,
                      folderId!,
                      folderName,
                      fileId,
                      fileName,
                      fileType,
                      fileSize,
                      false,
                    );
            },
            child: SizedBox(
              height: 40,

              child: Row(
                children: [
                  Icon(
                    Icons.star_border_outlined,
                    color: Colors.white70,
                    size: 23,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Favourites",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            height: 40,

            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white70,
                  size: 23,
                ),
                SizedBox(width: 15),
                Text(
                  "Details",
                  style: GoogleFonts.urbanist(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              isFolder
                  ? firestoreService.deleteFolder(uid, folderId!)
                  : firestoreService.deleteFileMetaData(
                      uid,
                      folderId!,
                      fileId!,
                    );
            },
            child: Row(
              children: [
                SizedBox(width: 5),
                SizedBox(
                  height: 40,

                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.red,
                        size: 18,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Delete",
                        style: GoogleFonts.urbanist(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MenuItems extends StatelessWidget {

//   const MenuItems({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     FirebaseFirestoreService firestoreService = FirebaseFirestoreService();

//     return 
//   }
// }
