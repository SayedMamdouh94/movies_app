import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/core/data/repos/app_repo.dart';
import 'package:movies_app/core/networking/api_service.dart';
import 'package:movies_app/core/networking/dio_factory.dart';
import 'package:movies_app/core/services/file_multi_picker_service.dart';
import 'package:movies_app/core/services/file_picker_factory.dart';
import 'package:movies_app/core/services/file_picker_service.dart';
import 'package:movies_app/core/services/file_uploading_factory.dart';
import 'package:movies_app/core/services/file_uploading_service.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  Dio dio = DioFactory.init();
  // API SERVICE
  getIt.registerLazySingleton(() => ApiService(dio));

  // FILE UPLOADER FACTORY
  getIt.registerLazySingleton(
    () => FileUploadingFactory(
      imageUploadingService: ImageUploadingService(),
      pdfUploadingService: PDFUploadingService(),
    ),
  );

  // APP REPO
  getIt.registerLazySingleton(() => AppRepo(getIt(), getIt()));

  // FILE PICKER Factory
  getIt.registerLazySingleton(
    () => FilePickerFactory(
      cameraPicker: ImagePickerFromCameraService(),
      galleryPicker: ImagePickerFromGalleryService(),
      pdfPicker: FilePDFPickerService(),
      multiPicker: ImageMultiPickerService(),
      videoPicker: VideoPickerService(),
    ),
  );
  
}
