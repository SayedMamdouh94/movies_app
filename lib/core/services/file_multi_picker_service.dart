import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class FileMultiPickerService {
  Future<List<File>> pickFiles();
}

class ImageMultiPickerService implements FileMultiPickerService {
  @override
  Future<List<File>> pickFiles() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    return pickedImages.map((e) => File(e.path)).toList();
  }
}
