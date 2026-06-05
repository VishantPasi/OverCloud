import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcloud/services/secure_storage_service.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future storeUserDetails(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> data = await _firebaseFirestore
        .collection("users")
        .doc(uid)
        .get();

    final userData = data.data();

    await SecureStorageService.setFullName(userData?["fullName"]);
    await SecureStorageService.setEmail(userData?["email"]);
    await SecureStorageService.setUID(uid);
  }
}
