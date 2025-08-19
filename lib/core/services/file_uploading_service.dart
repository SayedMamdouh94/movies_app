import 'dart:io';


import 'package:dio/dio.dart';
import 'package:movies_app/core/data/models/upload_file_response_model.dart';
import 'package:movies_app/core/di/dependency_injection.dart';
import 'package:movies_app/core/local_secure_storage/local_secure_storage.dart';
import 'package:movies_app/core/networking/api_service.dart';

abstract class FileUploadingService {
  ApiService apiService = getIt<ApiService>();

  Future<UploadFileResponseModel?> uploadFile(File? file);
}

class ImageUploadingService extends FileUploadingService {
  @override
  Future<UploadFileResponseModel?> uploadFile(
    File? file,
    
  ) async {
    if (file == null || !file.existsSync()) {
      return null;
    }
    try {
      final token = await LocalSecureStorage.accessToken;
      final response = await apiService.uploadImage(
        FormData.fromMap({'file': await MultipartFile.fromFile(file.path)}),
        token,
     
      );
      if (response.success) return response;
      return null;
    } on DioException catch (_) {
      return null;
    }
  }
}

class PDFUploadingService extends FileUploadingService {
  @override
  Future<UploadFileResponseModel?> uploadFile(
    File? file,
  
  ) async {
    if (file == null || !file.existsSync()) {
      return null;
    }
    try {
      final token = await LocalSecureStorage.accessToken;
      final response = await apiService.uploadPdf(
        FormData.fromMap({'file': await MultipartFile.fromFile(file.path)}),
        token,
     
      );
      if (response.success) return response;
      return null;
    } on DioException catch (_) {
      return null;
    }
  }
}
