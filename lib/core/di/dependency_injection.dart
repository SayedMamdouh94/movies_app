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
import 'package:movies_app/features/popular_people/data/apis/popular_people_api_service.dart';
import 'package:movies_app/features/popular_people/data/repo/popular_people_repo.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  Dio dio = DioFactory.init();
  // API SERVICES
  getIt.registerLazySingleton(() => ApiService(dio));
  getIt.registerLazySingleton(() => PopularPeopleApiService(dio));

  // REPOSITORIES
  getIt.registerLazySingleton(() => PopularPeopleRepo(getIt()));

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
