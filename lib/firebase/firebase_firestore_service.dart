import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overcloud/services/secure_storage_service.dart';
import 'package:overcloud/utils/file_category.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FileCategory _category = FileCategory();

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

  void deleteFolder(String uid, String folderId, bool isStarred) async {
    try {
      final folder = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('folders')
          .doc(folderId)
          .collection('files')
          .get();

      for (var doc in folder.docs) {
        print(doc.data());

        deleteFileMetaData(
          uid,
          folderId,
          doc.id,
          doc.data()['fileType'],
          doc.data()['fileSize'],
          doc.data()['isStarred'],
        );
        deleteFileMetaDataForDefaultFolders(
          uid,
          doc.id,
          doc.data()['fileType'],
        );
      }

      DocumentReference deleteFolder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId);

      await deleteFolder.delete();

      print(isStarred);

      isStarred
          ? removeFromStarred(uid, folderId, null, null, null, true)
          : null;
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
    int? fileSize,
    String? path,
    bool isStarred,
  ) async {
    try {
      DateTime dateTime = DateTime.now();
      if (folderId != "videos" ||
          folderId != "photos" ||
          folderId != "music" ||
          folderId != "documents") {
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
          isStarred,
        );

        updateOverallMetadata(uid, fileType!, 1, fileSize ?? 0, true);
      } else {
        createRecentFilesMetaData(
          uid,
          folderId,
          folderId,
          fileName,
          fileType,
          fileSize,
          path,
          isStarred,
        );
        updateOverallMetadata(uid, fileType!, 1, fileSize ?? 0, true);

        createFileMetaDataForDefaultFolders(
          uid,
          folderId,
          fileName,
          fileType,
          fileSize,
          path,
          isStarred,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void createFileMetaDataForDefaultFolders(
    String uid,
    String fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String? path,
    bool isStarred,
  ) async {
    String fileCategory = _category.getFileCategory(fileType!);
    try {
      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(fileCategory)
          .collection("files")
          .doc();

      await folder.set({
        "fileId": fileId,
        "fileName": fileName,
        "modifiedOn": dateTime.toString(),
        "fileType": fileType,
        "fileSize": fileSize,
        "isStarred": false,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteFileMetaDataForDefaultFolders(
    String uid,
    String fileId,
    String fileType,
  ) async {
    String fileCategory = _category.getFileCategory(fileType!);
    try {
      final folder = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(fileCategory)
          .collection("files")
          .where("fileId", isEqualTo: fileId)
          .get();

      for (var doc in folder.docs) {
        doc.reference.delete();
      }
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

  void deleteFileMetaData(
    String uid,
    String folderId,
    String fileId,
    String fileType,
    int fileSize,
    bool isStarred,
  ) async {
    try {
      final folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderId)
          .collection("files")
          .doc(fileId);

      await folder.delete();

      updateOverallMetadata(uid, fileType, 1, fileSize, false);

      isStarred
          ? updateOverallMetadata(uid, "starred", 1, fileSize, false)
          : null;

      removeFromStarred(uid, folderId, fileId, null, fileSize, false);
      deleteRecentFile(uid, folderId, fileId, false);

      print("errorrrrrrrr: $uid,$fileId,$fileType");
      // deleteFileMetaDataForDefaultFolders(uid,fileId,fileType);
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
    int? fileSize,
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

      updateOverallMetadata(uid, "starred", 1, fileSize ?? 0, true);
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
    int? fileSize,
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
        updateOverallMetadata(uid, "starred", 1, fileSize ?? 0, false);

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

        updateOverallMetadata(uid, "starred", 1, fileSize ?? 0, false);
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
    int? fileSize,
    String? path,
    bool isStarred,
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
        "isStarred": isStarred,
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

  void deleteRecentFile(
    String uid,
    String folderId,
    String? fileId,
    bool isFolder,
  ) async {
    try {
      if (isFolder) {
        print("dsafd: $folderId");
        final folder = await _firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection("recents")
            .where("folderId", isEqualTo: folderId)
            .get();

        for (var docs in folder.docs) {
          docs.reference.delete();
        }
      } else {
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

  //overallMetadata

  void createOverallMetadataFolders(String uid, String fileType) async {
    try {
      DocumentSnapshot existingFolders = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("overallMetadata")
          .doc(fileType)
          .get();

      if (existingFolders.exists) {
        return;
      }

      DateTime dateTime = DateTime.now();
      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("overallMetadata")
          .doc(fileType);

      await folder.set({
        "fileType": fileType,
        "totalCount": 0,
        "totalSize": 0,
        "modifiedOn": dateTime.toString(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> getOverallMetadata(
    String uid,
    String fileType,
  ) async {
    try {
      final metadata = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("overallMetadata")
          .where("fileType", isEqualTo: fileType)
          .get();

      if (metadata.docs.isNotEmpty) {
        return metadata.docs.first;
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  void updateOverallMetadata(
    String uid,
    String fileType,
    int newTotalCount,
    int newTotalSize,
    bool isIncrementing,
  ) async {
    String fileCategory = _category.getFileCategory(fileType);
    try {
      // Normalize file types

      final metadata = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("overallMetadata")
          .where("fileType", isEqualTo: fileCategory)
          .get();

      final overall = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("overallMetadata")
          .where("fileType", isEqualTo: "overall")
          .get();

      // final private = await _firebaseFirestore
      //     .collection("users")
      //     .doc(uid)
      //     .collection("overallMetadata")
      //     .where("fileType", isEqualTo: "private")
      //     .get();

      final starred = await _firebaseFirestore
          .collection("users")
          .doc(uid)
          .collection("overallMetadata")
          .where("fileType", isEqualTo: "starred")
          .get();

      DateTime dateTime = DateTime.now();

      if (fileType == "starred") {
        if (starred.docs.isNotEmpty) {
          if (isIncrementing) {
            await starred.docs.first.reference.update({
              "totalCount": FieldValue.increment(newTotalCount),
              "totalSize": FieldValue.increment(newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
          } else {
            await starred.docs.first.reference.update({
              "totalCount": FieldValue.increment(-newTotalCount),
              "totalSize": FieldValue.increment(-newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
          }
        }
      } else {
        if (metadata.docs.isNotEmpty) {
          if (isIncrementing) {
            await metadata.docs.first.reference.update({
              "totalCount": FieldValue.increment(newTotalCount),
              "totalSize": FieldValue.increment(newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
            await overall.docs.first.reference.update({
              "totalCount": FieldValue.increment(newTotalCount),
              "totalSize": FieldValue.increment(newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
          } else {
            await metadata.docs.first.reference.update({
              "totalCount": FieldValue.increment(-newTotalCount),
              "totalSize": FieldValue.increment(-newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
            await overall.docs.first.reference.update({
              "totalCount": FieldValue.increment(-newTotalCount),
              "totalSize": FieldValue.increment(-newTotalSize),
              "modifiedOn": dateTime.toString(),
            });
          }
        }
      }
    } catch (e) {
      debugPrint("updateOverallMetadata Error: $e");
    }
  }
}
