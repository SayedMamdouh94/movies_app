import 'package:movies_app/core/services/file_uploading_service.dart';

class FileUploadingFactory {
  final FileUploadingService imageUploadingService;
  final FileUploadingService pdfUploadingService;
  FileUploadingFactory({
    required this.imageUploadingService,
    required this.pdfUploadingService,
  });
  FileUploadingService getUploader(FileUploadingType type) {
    switch (type) {
      case FileUploadingType.image:
        return imageUploadingService;
      case FileUploadingType.pdf:
        return pdfUploadingService;
    }
  }
}

enum FileUploadingType { image, pdf }
