import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overcloud/models/RequestModels/create_folder_request_model.dart';
import 'package:overcloud/retrofit/retro_service.dart';
import 'package:overcloud/utils/error_dialog.dart';


class FirestoreCreateOperations {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void isFolderExists(
    String uid,
    String folderName,
    BuildContext context,
  ) async {
    try {
      DocumentSnapshot existingFolders = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("folders")
          .doc(folderName)
          .get();

      if (existingFolders.exists) {
        errorMessage(
          "Folder Already Exists",
          "A folder with the same name already exists.",
          context,
        );
      } else {
        debugPrint("Folder does not exist.");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void createFolder(String uid, String parentId, String folderName, String? folderPath, BuildContext context) async {
    try {
      isFolderExists(uid, folderName, context);
      DateTime dateTime = DateTime.now();

      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc();

      RetrofitService.getClient()
          .createFolder(
            CreateFolderRequestModel(uid: uid, folderName: folderName, folderPath: folderPath),
          )
          .then((_) {
            return folder.set({
              "id": folder.id,
              "parentId": parentId,
              "name": folderName,
              "type": "folder",
              "isStarred": false,
              "isTrashed": false,
              "createdOn": dateTime.toString(),
              "modifiedOn": dateTime.toString(),
            });
          })
          .then((_) {
            debugPrint("Folder created successfully.");
          })
          .catchError((e) {
            debugPrint("Failed to create folder: $e");
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void createFile(
    String uid,
    String parentId,
    String fileName,
    String type,
    int size,
    BuildContext context,
  ) async {
    try {
      // isFolderExists(uid, fileName, context);
      DateTime dateTime = DateTime.now();

      DocumentReference file = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc();

      await file
          .set({
            "id": file.id,
            "parentId": parentId,
            "name": fileName,
            "type": type,
            "size": size,
            "isStarred": false,
            "isTrashed": false,
            "createdOn": dateTime.toString(),
            "modifiedOn": dateTime.toString(),
          })
          .then((_) {
            debugPrint("File created successfully on firestore.");
          })
          .catchError((e) {
            debugPrint("Failed to create file on firestore: $e");
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
