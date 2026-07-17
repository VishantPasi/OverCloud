import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overcloud/models/RequestModels/delete_folder_request_model.dart';
import 'package:overcloud/retrofit/retro_service.dart';

class FirestoreDeleteOperations {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> deleteFolder(String uid, String id, String folderName, String folderPath) async {

  RetrofitService.getClient().deleteFolder(DeleteFolderRequestModel(uid: uid, folderName: folderName, folderPath: folderPath));

  // Find immediate children
  final children = await _firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('folders')
      .where('parentId', isEqualTo: id)
      .get();

  // Recursively delete each child
  for (final child in children.docs) {
    await deleteFolder(uid, child['id'],"","" );
  }

  // Delete files belonging to this folder
  final files = await _firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('files')
      .where('parentId', isEqualTo: id)
      .get();

  for (final file in files.docs) {
    await file.reference.delete();
  }

  // Finally delete this folder
  final folder = _firebaseFirestore
      .collection('users')
      .doc(uid)
      .collection('folders')
      .doc(id);

  await folder.delete();
}
}
