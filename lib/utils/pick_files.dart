import 'package:file_picker/file_picker.dart';

class FilePickingService {

  Future<void> pickAFile() async {
FilePickerResult? result = await FilePicker.pickFiles();
try {
  if (result != null) {
  PlatformFile file = result.files.first;

  print(file.name);
  print(file.bytes);
  print(file.size);
  print(file.extension);
  print(file.path);
  } else {
  // User canceled the picker
}
} catch (e) {
  print(e.toString());

}

  

  }

  
}
