import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/utils/rename_file_bottomsheet.dart';
import 'package:overcloud/utils/rename_folder_bottomsheet.dart';
import 'package:popover/popover.dart';

class ShowPopOver {
  FirebaseFirestoreService firestoreService = FirebaseFirestoreService();

  Future<Object?> popOverFilesContent(
    BuildContext buttonContext,
    BuildContext context,
    String uid,
    String? folderId,
    String? folderName,
    String path,
    String? currentFolderId,
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
        child: menuItemsFilesContent(
          context,
          uid,
          folderId,
          folderName,
          path,
          currentFolderId,
          isFolder,
          isStarred,
        ),
      ),
      width: currentFolderId == "starred" ? 130 : 150 ,
      height: currentFolderId == "starred" ? 155 : 210,
      direction: PopoverDirection.bottom,
      radius: 20,
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
    );
  }


  Future<Object?> popOverFoldersPage(
    BuildContext buttonContext,
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
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
        child: menuItemsFoldersPage(
          context,
          uid,
          folderId,
          fileId,
          fileName,
          fileType,
          fileSize,
          path,
          currentFolderId,
          isFolder,
          isStarred,
        ),
      ),
      width: currentFolderId == "starred" ? 130 : 150 ,
      height: currentFolderId == "starred" ? 155 : 210,
      direction: PopoverDirection.bottom,
      radius: 20,
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
    );
  }

  Future<Object?> popOverStarredPage(
    BuildContext buttonContext,
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? folderName,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
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
        child: menuItemsStarredPage(
          context,
          uid,
          folderId,
          fileId,
          folderName,
          fileName,
          fileType,
          fileSize,
          path,
          currentFolderId,
          isFolder,
          isStarred,
        ),
      ),
      width: currentFolderId == "starred" ? 130 : 150 ,
      height: currentFolderId == "starred" ? 155 : 210,
      direction: PopoverDirection.bottom,
      radius: 20,
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
    );
  }

  Widget menuItemsStarredPage(
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? folderName,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
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
                      fileType!,
                      path
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
                "errorr: $folderId, $folderName, $fileId, $fileName, $fileType, $fileSize $isStarred,$isFolder",
              );
              if (isStarred){
                isFolder ? 
              firestoreService.removeFromStarred(uid, folderId!, null, path, null, null,isFolder): firestoreService.removeFromStarred(uid, folderId, fileId, path, fileSize, fileType,isFolder);

                    Navigator.pop(context);
              
              }else{
                isFolder
                  ? firestoreService.addToStarred(
                      uid,
                      folderId!,
                      folderName,
                      fileId,
                      fileName,
                      fileType,
                      fileSize,
                      path,
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
                      path,
                      false,
                    );

                    Navigator.pop(context);
              }
              
            },
            child: SizedBox(
              height: 40,

              child: Row(
                children: [
                  isStarred ? Icon(
                    Icons.star_border_outlined,
                    color: Colors.white70,
                    size: 23,
                  ): Row(
                    children: [
                      SizedBox(width: 4,),
                      FaIcon(FontAwesomeIcons.solidStar, color: Colors.white70, size: 16,),
                    ],
                  ),
                  SizedBox(width: 15),
                  isStarred ? Text(
                    "Unstar",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ): Text(
                    "Starred",
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
          currentFolderId != "starred" ?  SizedBox(height: 10) : SizedBox(),
         currentFolderId != "starred" ?  Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ) : SizedBox() ,
         currentFolderId != "starred" ?  SizedBox(height: 5) : SizedBox(),
         currentFolderId != "starred" ?   GestureDetector(
            onTap: () {
              Navigator.pop(context);
              isFolder
                  ? firestoreService.deleteFolder(uid, folderId!,isStarred)
                  : firestoreService.deleteFileMetaData(
                      uid,
                      folderId!,
                      fileId!,
                      fileType!,
                      fileSize!,
                      path,
                      isStarred
                      

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
          ) : SizedBox(),
        ],
      ),
    );
  }




   Future<Object?> popOverRecentFilesPage(
    BuildContext buttonContext,
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
    bool isFolder,
    bool isStarred
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
        child: menuItemsRecentFilesPage(
          context,
          uid,
          folderId,
          fileId,
          fileName,
          fileType,
          fileSize,
          path,
          currentFolderId,
          isFolder,
          isStarred
        ),
      ),
      width: 130 ,
      height: 170,
      direction: PopoverDirection.bottom,
      radius: 20,
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
    );
  }

  //150, 210

  Widget menuItemsRecentFilesPage(
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
    bool isFolder,
    bool isStarred

  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              print("contexttt:  $folderId, $fileId, $fileName");
               renameFileBottomSheet(
                      context,
                      uid,
                      folderId!,
                      fileId!,
                      fileName!,
                      fileType!,
                      path
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
          currentFolderId != "starred" ?  SizedBox(height: 10) : SizedBox(),
         currentFolderId != "starred" ?  Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ) : SizedBox() ,
         currentFolderId != "starred" ?  SizedBox(height: 5) : SizedBox(),
         currentFolderId != "starred" ?   GestureDetector(
            onTap: () {
              Navigator.pop(context);
              isFolder
                  ? firestoreService.deleteFolder(uid, folderId!,isStarred)
                  : firestoreService.deleteFileMetaData(
                      uid,
                      folderId!,
                      fileId!,
                      fileType!,
                      fileSize!,
                      path,
                      isStarred
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
          ) : SizedBox(),
        ],
      ),
    );
  }


  //  Future<Object?> popOver(
  //   BuildContext buttonContext,
  //   BuildContext context,
  //   String uid,
  //   String? folderId,
  //   String? fileId,
  //   String? folderName,
  //   String? fileName,
  //   String? fileType,
  //   String? fileSize,
  //   String path,
  //   String? currentFolderId,
  //   bool isFolder,
  //   bool isStarred,
  // ) {
  //   return showPopover(
  //     context: buttonContext,
  //     bodyBuilder: (_) => Container(
  //       decoration: BoxDecoration(
  //         color: const Color(0xFF1E1E1E),
  //         borderRadius: BorderRadius.circular(16),
  //         border: Border.all(
  //           color: Colors.white.withValues(alpha: 0.1),
  //           width: 1,
  //         ),
  //       ),
  //       child: menuItems(
  //         context,
  //         uid,
  //         folderId,
  //         fileId,
  //         folderName,
  //         fileName,
  //         fileType,
  //         fileSize,
  //         path,
  //         currentFolderId,
  //         isFolder,
  //         isStarred,
  //       ),
  //     ),
  //     width: currentFolderId == "starred" ? 130 : 150 ,
  //     height: currentFolderId == "starred" ? 155 : 210,
  //     direction: PopoverDirection.bottom,
  //     radius: 20,
  //     backgroundColor: Color.fromRGBO(50, 50, 50, 0.945),
  //   );
  // }

  // //150, 210

  // Widget menuItems(
  //   BuildContext context,
  //   String uid,
  //   String? folderId,
  //   String? fileId,
  //   String? folderName,
  //   String? fileName,
  //   String? fileType,
  //   String? fileSize,
  //   String path,
  //   String? currentFolderId,
  //   bool isFolder,
  //   bool isStarred,
  // ) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
  //     child: Column(
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //             isFolder
  //                 ? renameFolderBottomSheet(
  //                     context,
  //                     uid,
  //                     folderId!,
  //                     folderName!,
  //                   )
  //                 : renameFileBottomSheet(
  //                     context,
  //                     uid,
  //                     folderId!,
  //                     fileId!,
  //                     fileName!,
  //                   );
  //           },
  //           child: SizedBox(
  //             height: 40,

  //             child: Row(
  //               children: [
  //                 Icon(Icons.edit, color: Colors.white70, size: 23),
  //                 SizedBox(width: 15),
  //                 Text(
  //                   "Rename",
  //                   style: GoogleFonts.urbanist(
  //                     color: Colors.white70,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         GestureDetector(
  //           onTap: () {
  //             print(
  //               "errorr: $folderId, $folderName, $fileId, $fileName, $fileType, $fileSize $isStarred,$isFolder",
  //             );
  //             if (isStarred){
  //               isFolder ? 
  //             firestoreService.removeFromStarred(uid, folderId!, null, path, isFolder): firestoreService.removeFromStarred(uid, folderId, fileId, path,isFolder);

  //                   Navigator.pop(context);
              
  //             }else{
  //               isFolder
  //                 ? firestoreService.addToStarred(
  //                     uid,
  //                     folderId!,
  //                     folderName,
  //                     fileId,
  //                     fileName,
  //                     fileType,
  //                     fileSize,
  //                     path,
  //                     true,
  //                   )
  //                 : firestoreService.addToStarred(
  //                     uid,
  //                     folderId!,
  //                     folderName,
  //                     fileId,
  //                     fileName,
  //                     fileType,
  //                     fileSize,
  //                     path,
  //                     false,
  //                   );

  //                   Navigator.pop(context);
  //             }
              
  //           },
  //           child: SizedBox(
  //             height: 40,

  //             child: Row(
  //               children: [
  //                 isStarred ? Icon(
  //                   Icons.star_border_outlined,
  //                   color: Colors.white70,
  //                   size: 23,
  //                 ): Row(
  //                   children: [
  //                     SizedBox(width: 4,),
  //                     FaIcon(FontAwesomeIcons.solidStar, color: Colors.white70, size: 16,),
  //                   ],
  //                 ),
  //                 SizedBox(width: 15),
  //                 isStarred ? Text(
  //                   "Unstar",
  //                   style: GoogleFonts.urbanist(
  //                     color: Colors.white70,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ): Text(
  //                   "Starred",
  //                   style: GoogleFonts.urbanist(
  //                     color: Colors.white70,
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //      SizedBox(height: 5),
  //         SizedBox(
  //           height: 40,

  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.info_outline_rounded,
  //                 color: Colors.white70,
  //                 size: 23,
  //               ),
  //               SizedBox(width: 15),
  //               Text(
  //                 "Details",
  //                 style: GoogleFonts.urbanist(
  //                   color: Colors.white70,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         currentFolderId != "starred" ?  SizedBox(height: 10) : SizedBox(),
  //        currentFolderId != "starred" ?  Divider(
  //           color: Colors.white.withValues(alpha: 0.1),
  //           height: 2,
  //           thickness: 2,
  //         ) : SizedBox() ,
  //        currentFolderId != "starred" ?  SizedBox(height: 5) : SizedBox(),
  //        currentFolderId != "starred" ?   GestureDetector(
  //           onTap: () {
  //             Navigator.pop(context);
  //             isFolder
  //                 ? firestoreService.deleteFolder(uid, folderId!)
  //                 : firestoreService.deleteFileMetaData(
  //                     uid,
  //                     folderId!,
  //                     fileId!,
  //                   );
  //           },
  //           child: Row(
  //             children: [
  //               SizedBox(width: 5),
  //               SizedBox(
  //                 height: 40,

  //                 child: Row(
  //                   children: [
  //                     FaIcon(
  //                       FontAwesomeIcons.trashCan,
  //                       color: Colors.red,
  //                       size: 18,
  //                     ),
  //                     SizedBox(width: 15),
  //                     Text(
  //                       "Delete",
  //                       style: GoogleFonts.urbanist(
  //                         color: Colors.red,
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ) : SizedBox(),
  //       ],
  //     ),
  //   );
  // }




 Widget menuItemsFoldersPage(
    BuildContext context,
    String uid,
    String? folderId,
    String? fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String path,
    String? currentFolderId,
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
              renameFileBottomSheet(
                      context,
                      uid,
                      folderId!,
                      fileId!,
                      fileName!,
                      fileType!,
                      path
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
             
              if (isStarred){
                 firestoreService.removeFromStarred(uid, folderId, fileId, path, fileSize,fileType,isFolder);

                    Navigator.pop(context);
              
              }else{
                firestoreService.addToStarred(
                      uid,
                      folderId!,
                      null,
                      fileId,
                      fileName,
                      fileType,
                      fileSize,
                      path,
                      false,
                    );

                    Navigator.pop(context);
              }
              
            },
            child: SizedBox(
              height: 40,

              child: Row(
                children: [
                  isStarred ? Icon(
                    Icons.star_border_outlined,
                    color: Colors.white70,
                    size: 23,
                  ): Row(
                    children: [
                      SizedBox(width: 4,),
                      FaIcon(FontAwesomeIcons.solidStar, color: Colors.white70, size: 16,),
                    ],
                  ),
                  SizedBox(width: 15),
                  isStarred ? Text(
                    "Unstar",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ): Text(
                    "Starred",
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
          currentFolderId != "starred" ?  SizedBox(height: 10) : SizedBox(),
         currentFolderId != "starred" ?  Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ) : SizedBox() ,
         currentFolderId != "starred" ?  SizedBox(height: 5) : SizedBox(),
         currentFolderId != "starred" ?   GestureDetector(
            onTap: () {
              Navigator.pop(context);
              firestoreService.deleteFileMetaData(
                      uid,
                      folderId!,
                      fileId!,
                      fileType!,
                      fileSize!,
                      path,
                      isStarred,
                      
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
          ) : SizedBox(),
        ],
      ),
    );
  }





  Widget menuItemsFilesContent(
    BuildContext context,
    String uid,
    String? folderId,
    String? folderName,
    String path,
    String? currentFolderId,
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
renameFolderBottomSheet(
                      context,
                      uid,
                      folderId!,
                      folderName!,
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
              // print(
              //   // "errorr: $folderId, $folderName, $fileId, $fileName, $fileType, $fileSize $isStarred,$isFolder",
              // );
              if (isStarred){
              
              firestoreService.removeFromStarred(uid, folderId!, null, path, null, null,isFolder);

                    Navigator.pop(context);
              
              }else{
                firestoreService.addToStarred(
                      uid,
                      folderId!,
                      folderName,
                      null,
                      null,
                      null,
                     null,
                      path,
                      true,
                    )
                  ;

                    Navigator.pop(context);
              }
              
            },
            child: SizedBox(
              height: 40,

              child: Row(
                children: [
                  isStarred ? Icon(
                    Icons.star_border_outlined,
                    color: Colors.white70,
                    size: 23,
                  ): Row(
                    children: [
                      SizedBox(width: 4,),
                      FaIcon(FontAwesomeIcons.solidStar, color: Colors.white70, size: 16,),
                    ],
                  ),
                  SizedBox(width: 15),
                  isStarred ? Text(
                    "Unstar",
                    style: GoogleFonts.urbanist(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ): Text(
                    "Starred",
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
          currentFolderId != "starred" ?  SizedBox(height: 10) : SizedBox(),
         currentFolderId != "starred" ?  Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ) : SizedBox() ,
         currentFolderId != "starred" ?  SizedBox(height: 5) : SizedBox(),
         currentFolderId != "starred" ?   GestureDetector(
            onTap: () {
              Navigator.pop(context);
             firestoreService.deleteFolder(uid, folderId!,isStarred)
                  ;
                  
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
          ) : SizedBox(),
        ],
      ),
    );
  }
}


