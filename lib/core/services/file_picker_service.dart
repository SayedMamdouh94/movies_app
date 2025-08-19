import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

abstract class FilePickerService {
  Future<File?> pickFile();
}

class ImagePickerFromCameraService implements FilePickerService {
  @override
  Future<File?> pickFile() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}

class ImagePickerFromGalleryService implements FilePickerService {
  @override
  Future<File?> pickFile() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}

class FilePDFPickerService implements FilePickerService {
  @override
  Future<File?> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      return File(pickedFile.files.single.path!);
    }
    return null;
  }
}

class VideoPickerService implements FilePickerService {
  @override
  Future<File?> pickFile() async {
    final pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );
    return pickedVideo != null ? File(pickedVideo.path) : null;
  }
}
