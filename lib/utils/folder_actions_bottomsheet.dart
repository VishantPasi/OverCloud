
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/utils/rename_folder_bottomsheet.dart';


Future<String?> folderActionsBottomSheet(BuildContext context,String uid, String folderId, String folderName) async {
  FirebaseFirestoreService firestore = FirebaseFirestoreService();
  
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
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 50,),
                              Text("Choose an Action", style: GoogleFonts.urbanist(color: Colors.white,fontSize: 20),),
                              ListTile(
                                leading: const Icon(
                                  Icons.edit_rounded,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Rename Folder',
                                  style: GoogleFonts.urbanist(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  renameFolderBottomSheet(context, uid, folderId, folderName);
                                },
                              ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal:  20.0),
                                 child: Divider(
                                           color: Colors.white.withValues(alpha: 0.1),
                                           height: 2,
                                           thickness: 2,
                                         ),
                               ),

                              ListTile(
                                leading: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.redAccent,
                                ),
                                title: Text(
                                  'Delete Folder',
                                  style: GoogleFonts.urbanist(color: Colors.redAccent),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  firestore.deleteFolder(uid, folderId);
                                  
                                },
                              ),
                            ],
                          );
                        },
                      );

}