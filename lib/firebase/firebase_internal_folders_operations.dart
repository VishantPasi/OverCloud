import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcloud/utils/file_category.dart';

class FirebaseInternalFoldersOperations {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FileCategory _category = FileCategory();

  Future<void> createInternalFolder(
    String uid,
    String folderName,
  ) async {
    try {
      DateTime dateTime = DateTime.now();

      DocumentReference folder = _firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection("folder")
          .doc(folderName);

      await folder.set({
        "parentFolderId": null,
        "folderId": folder.id,
        "folderName": folderName,
        "createdOn": dateTime.toString(),
        "modifiedOn": dateTime.toString(),
        "isStarred": false,
        "isTrashed": false,
      });
    } catch (e) {
      print("Error creating internal folder: $e");
    }
  }
}