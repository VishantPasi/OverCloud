import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickOneFile {
  Future<PlatformFile?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        return result.files.first;
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Future<PlatformFile?> pickFileFromCamera(){
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   } catch (e) {

  //   }
  // }
}
