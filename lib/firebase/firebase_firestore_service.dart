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
    createDefaultFolders(uid, "starred");
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
        "folderName":
            "${folderName[0].toUpperCase()}${folderName.substring(1)}",
        "modifiedOn": dateTime.toString(),
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
        "modifiedOn": dateTime.toString(),
        "isStarred": false,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void renameFolderName(
    String uid,
    String folderId,
    String newFolderName,
  ) async {
    try {
      DateTime dateTime = DateTime.now();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .update({
            "folderName": newFolderName,
            "modifiedOn": dateTime.toString(),
          });
      renameStarredFolderOrFile(uid, folderId, null, newFolderName, null, true);
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
      removeFromStarred(uid, folderId, null, null, true);
      deleteRecentFile(uid, folderId, null, true);
      
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //cannot create folders files,photos...

  //Files Metadata Crud
  void createFileMetaData(
    String uid,
    String folderId,
    String? fileName,
    String? fileType,
    String? fileSize,
    String? path,
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
        "modifiedOn": dateTime.toString(),
        "fileType": fileType,
        "fileSize": fileSize,
        "isStarred": false,
      });

      createRecentFilesMetaData(
        uid,
        folderId,
        folder.id,
        fileName,
        fileType,
        fileSize,
        path,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFilesMetaDataList(
    String uid,
    String folderId,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc(folderId)
        .collection("files")
        .snapshots();
  }

  void renameFileName(
    String uid,
    String folderId,
    String fileId,
    String newFileName,
  ) async {
    try {
      DateTime dateTime = DateTime.now();
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .collection("files")
          .doc(fileId)
          .update({"fileName": newFileName, "modifiedOn": dateTime.toString()});

      renameRecentFiles(uid, fileId, newFileName);

      renameStarredFolderOrFile(uid, null, fileId, null, newFileName, false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteFileMetaData(String uid, String folderId, String fileId) async {
    try {
      final folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .collection("files")
          .doc(fileId);

      await folder.delete();

      removeFromStarred(uid, folderId, fileId, null, false);
      deleteRecentFile(uid, folderId, fileId, false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addToStarred(
    String uid,
    String folderId,
    String? folderName,
    String? fileId,
    String? fileName,
    String? fileType,
    String? fileSize,
    String? path,
    bool isFolder,
  ) async {
    try {
      DateTime dateTime = DateTime.now();

      DocumentReference starred = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc("starred")
          .collection("foldersAndFiles")
          .doc();

      if (isFolder) {
        print("started adding");
        DocumentReference update = _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc(folderId);

        await update.update({"isStarred": true});
        print("don update");

        await starred.set({
          "folderName": folderName,
          "folderId": folderId,
          "isFolder": true,
          "path": path,
          "modifiedOn": dateTime.toString(),
        });

        print("ended adding");
      } else {
        DocumentReference update = _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc(folderId)
            .collection("files")
            .doc(fileId);

        await update.update({"isStarred": true});

        await starred.set({
          "fileName": fileName,
          "folderId": folderId,
          "fileId": fileId,
          "fileType": fileType,
          "fileSize": fileSize,
          "path": path,
          "isFolder": false,
          "modifiedOn": dateTime.toString(),
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStarredFoldersAndFiles(
    String uid,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc("starred")
        .collection("foldersAndFiles")
        .snapshots();
  }

  void renameStarredFolderOrFile(
    String uid,
    String? folderId,
    String? fileId,
    String? newFolderName,
    String? newFileName,
    bool isFolder,
  ) async {
    try {
      DateTime dateTime = DateTime.now();

      print(
        "errorrrrrr: $folderId,$fileId,$newFolderName,$newFileName,$isFolder",
      );

      if (isFolder) {
        final starred = await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc("starred")
            .collection("foldersAndFiles")
            .where("folderId", isEqualTo: folderId)
            .get();

        for (var docs in starred.docs) {
          docs.reference.update({
            "folderName": newFolderName,
            "modifiedOn": dateTime.toString(),
          });
        }
      } else {
        final starred = await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc("starred")
            .collection("foldersAndFiles")
            .where("fileId", isEqualTo: fileId)
            .get();

        for (var docs in starred.docs) {
          docs.reference.update({
            "fileName": newFileName,
            "modifiedOn": dateTime.toString(),
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeFromStarred(
    String uid,
    String? folderId,
    String? fileId,
    String? filePath,
    bool isFolder,
  ) async {
    try {
      if (isFolder) {
        final folder = await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc("starred")
            .collection("foldersAndFiles")
            .where("folderId", isEqualTo: folderId)
            .get();

        for (var docs in folder.docs) {
          docs.reference.delete();
        }

        DocumentReference update = _firebaseFirestore.doc(filePath!);

        await update.update({"isStarred": false});
      } else {
        final folder = await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("folders")
            .doc("starred")
            .collection("foldersAndFiles")
            .where("fileId", isEqualTo: fileId)
            .get();

        for (var docs in folder.docs) {
          docs.reference.delete();
        }

        DocumentReference update = _firebaseFirestore.doc(filePath!);

        await update.update({"isStarred": false});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //recent files

  void createRecentFilesMetaData(
    String uid,
    String? folderId,
    String? fileId,
    String? fileName,
    String? fileType,
    String? fileSize,
    String? path,
  ) async {
    try {
      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("recents")
          .doc();

      await folder.set({
        "folderId": folderId,
        "fileId": fileId,
        "fileName": fileName,
        "modifiedOn": dateTime.toString(),
        "fileType": fileType,
        "fileSize": fileSize,
        "path": path,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentFilesMetaDataList(
    String uid,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('recents')
        .orderBy('modifiedOn', descending: true)
        .limit(3)
        .snapshots();
  }

  void renameRecentFiles(
    String uid,
    String? fileId,
    String? newFileName,
  ) async {
    try {
      DateTime dateTime = DateTime.now();

      print("errorrrrrr: $fileId,$newFileName");

      final recents = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("recents")
          .where("fileId", isEqualTo: fileId)
          .get();

      for (var docs in recents.docs) {
        docs.reference.update({
          "fileName": newFileName,
          "modifiedOn": dateTime.toString(),
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteRecentFile(String uid, String folderId, String? fileId, bool isFolder) async {
    try {
      if(isFolder){
        print("dsafd: $folderId");
        final folder = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("recents")
          .where("folderId", isEqualTo: folderId).get();

      for (var docs in folder.docs) {
        docs.reference.delete();
      }
      }
      else{
        final folder = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("recents")
          .where("fileId", isEqualTo: fileId)
          .get();

      for (var docs in folder.docs) {
        docs.reference.delete();
      }
      }
      
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
