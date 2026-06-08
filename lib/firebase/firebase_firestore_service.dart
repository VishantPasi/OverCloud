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

  void getUserData(String uid) async {
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>> files =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('folders')
            .doc('folderData')
            .collection('videos')
            .snapshots()
            .listen((snapshot) {
              for (var doc in snapshot.docs) {
                print(doc.data());
              }
            });
  }
}
