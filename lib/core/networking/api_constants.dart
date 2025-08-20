class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String _api = 'api';
  static const String upload = '$_api/File';
  static const String uploadPdf = '$upload/document';
  static const String uploadImage = '$upload/image';
  static const String deleteFile = '$_api/deletefile';
  static const String popularPeople = 'person/popular';
}
