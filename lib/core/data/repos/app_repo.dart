import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movies_app/core/data/models/upload_file_response_model.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/networking/api_service.dart';
import 'package:movies_app/core/services/file_uploading_factory.dart';

class AppRepo {
  final ApiService apiService;
  final FileUploadingFactory fileUploadingFactory;
  AppRepo(this.apiService, this.fileUploadingFactory);

  Future<void> deleteFile(String fileUrl) async {
    try {
      final token = await LocalSecureStorage.accessToken;
      await apiService.deleteFile(fileUrl, token);
    } on DioException catch (_) {}
  }

  Future<UploadFileResponseModel?> uploadImage(File? imageFile) async {
    return await fileUploadingFactory
        .getUploader(FileUploadingType.image)
        .uploadFile(imageFile);
  }

  Future<UploadFileResponseModel?> uploadPdf(File? file) async {
    return await fileUploadingFactory
        .getUploader(FileUploadingType.pdf)
        .uploadFile(file);
  }
}
