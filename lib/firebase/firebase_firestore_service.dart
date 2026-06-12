import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overcloud/services/secure_storage_service.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future storeUserDetails(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data = await _firebaseFirestore
        .collection("users")
        .doc(uid)
        .get();

    await SecureStorageService.setFullName(data.data()?["fullName"]);
    await SecureStorageService.setEmail(data.data()?["email"]);
    await SecureStorageService.setUID(uid);

    createDefaultFolders(uid, "photos");
    createDefaultFolders(uid, "documents");
    createDefaultFolders(uid, "videos");
    createDefaultFolders(uid, "music");
  }

  //FOLDER RELATED CRUD

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolderList(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('folders')
        .snapshots();
  }

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

      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderName);

      await folder.set({
        "folderName": folderName,
        "createdOn": dateTime.toString(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void createFolder(String uid, String folderName) async {
    try {
      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc();

      await folder.set({
        "folderName": folderName,
        "createdOn": dateTime.toString(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void renameFolder(String uid, String folderId, String newFolderName) async {
    try {
      DateTime dateTime = DateTime.now();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .update({
            "folderName": newFolderName,
            "createdOn": dateTime.toString(),
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteFolder(String uid, String folderId) async {
    try {
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId);

      await folder.delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Files Metadata Crud
  void createFileMetaData(
    String uid,
    String folderId,
    String? fileName,
    String? fileType,
    String? fileSize,
  ) async {
    try {
      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .collection("files")
          .doc();

      await folder.set({
        "fileName": fileName,
        "createdOn": dateTime.toString(),
        "fileType": fileType,
        "fileSize": fileSize,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolderFiles(
    String uid,
    String docId,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc(docId)
        .collection("files")
        .snapshots();
  }

  void deleteFileMetaData(String uid, String docId, String fileId) async {
    try {
      final folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(docId)
        .collection("files").doc(fileId);
          

      await folder.delete();
        
       }


      
     catch (e) {
      debugPrint(e.toString());
    }
  }
  
}
