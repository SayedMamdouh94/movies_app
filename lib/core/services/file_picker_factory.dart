
import 'package:movies_app/core/services/file_multi_picker_service.dart';
import 'package:movies_app/core/services/file_picker_service.dart';

class FilePickerFactory {
  FilePickerService cameraPicker;
  FilePickerService galleryPicker;
  FilePickerService pdfPicker;
  FilePickerService videoPicker;
  FileMultiPickerService multiPicker;
  FilePickerFactory({
    required this.cameraPicker,
    required this.galleryPicker,
    required this.pdfPicker,
    required this.multiPicker,
    required this.videoPicker,
  });
}
