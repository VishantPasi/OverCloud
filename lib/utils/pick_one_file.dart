import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickOneFile {
  Future<PlatformFile?> pickFile(String folderId) async {
    FileType fileType;

    switch (folderId) {
      case "photos":
        fileType = FileType.image;
        break;

      case "videos":
        fileType = FileType.video;
        break;

      case "music":
        fileType = FileType.audio;
        break;

      default:
        fileType = FileType.any;
    }
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
      );

      if (result != null) {
        return result.files.first;
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
