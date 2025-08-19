class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://injaz-api.runasp.net/';
  static const String _api = 'api';
  static const String upload = '$_api/File';
  static const String uploadPdf = '$upload/document';
  static const String uploadImage = '$upload/image';
  static const String deleteFile = '$_api/deletefile';
  static const String _auth = '$_api/Authentication';
  static const String login = '$_auth/login';
  static const String registerByEmail = '$_auth/register-Client-ByEmail';
  static const String registerByPhone = '$_auth/register-Client-ByPhone';
  static const String loginWith2FA = '$_auth/login-with-2fa';
  static const String sendOtpToEmail = '$_auth/send-otp-to-confirm-email';
  static const String confirmEmail = '$_auth/confirm-email';
  static const String resetPassword = '$_auth/forgot-password';
  static const String resetPasswordVerification = '$_auth/validate-reset-otp';
  static const String resetAndChangePassword = '$_auth/reset-password';
  static const String client = '$_api/Client';
  static const String profile = '$client/Get-Profile';
  static const String addAddress = '$client/add-addresses';
  static const String deleteAddress = '$client/delete';
  static const String addressDetails = '$client/Get-Address-by-{id}';
  static const String addresses = '$client/all-addresses';
  static const String updateAddress = '$client/update-address';
  static const String setDefaultAddress = 'set-default';
  static const String refreshToken = '$_auth/refresh-token';
  static const String updatePassword = '$_auth/change-password';

  static const String industry = '$_api/Industry';
  static const String industries = '$industry/All-Industries';

  static const String serviceProvider = '$_api/ServiceProvider';
  static const String serviceProviders = '$serviceProvider/Get-by-industry';

  static const String request = '$_api/Request';
  static const String requests = '$request/client-requests';
  static const String requestDetails = '$request/client-request/{id}';
  static const String requestAddress = '$request/Get-Address-By/{id}';
  static const String visit = '$_api/Visit';
  static const String visits = '$visit/client-visits/{id}';
  static const String acceptVisit = '$visit/{id}/accept';
  static const String rejectVisit = '$visit/{id}/reject';
  static const String rescheduleVisit = '$visit/{id}/suggest-preferred-time';

  static const String providerServices =
      '$_api/ServiceProviderService/{serviceProviderId}/services-by-type';
}
