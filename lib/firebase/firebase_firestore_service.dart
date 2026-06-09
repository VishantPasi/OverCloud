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
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolderList(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders')
        .snapshots();
  }

  void createFolder(String uid, String folderName) async {
    try {
      DateTime dateTime = DateTime.now();

      print(dateTime);

      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folders")
          .doc(folderName);

      await folder.set({"createdOn": dateTime.toString()});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

Stream<QuerySnapshot<Map<String, dynamic>>> getFolderFiles(String uid,String docId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('folders').doc(docId).collection("files")
        .snapshots();
  }

}
