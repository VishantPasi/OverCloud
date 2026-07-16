import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overcloud/models/RequestModels/create_folder_request_model.dart';
import 'package:overcloud/retrofit/retro_service.dart';

class FirestoreDefaultFoldersCreation {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createDefaultFolders(String uid, String folderName) async {
    try {
      DocumentSnapshot existingFolders = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("folders")
          .doc(folderName)
          .get();

      if (existingFolders.exists) {
        return;
      }

      await RetrofitService.getClient().createFolder(
        CreateFolderRequestModel(uid: uid, folderName: folderName),
      );

      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderName);

      await folder.set({
        "parentId": "",
        "id": folder.id,
        "name": folderName,
        "type": "folder",
        "createdOn": dateTime.toString(),
        "modifiedOn": dateTime.toString(),
      });
    } on DioException catch (e) {
      debugPrint("Status: ${e.response?.statusCode}");
      debugPrint("Body: ${e.response?.data}");
    }
  }
}
