abstract final class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://app.fnddelivery.com/api/mobile',
  );
  static const String imageBaseUrl = 'https://app.fnddelivery.com/uploads/';

  static const String login = '$baseUrl/login';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String signup = '$baseUrl/signup';
  static const String verifySignupOtp = '$baseUrl/signup/verify-otp';
  static const String completeProfile = '$baseUrl/complete-profile';
  static const String logout = '$baseUrl/logout';
  static const String storeDetails = '$baseUrl/store/details';
  static const String createRequest = '$baseUrl/store/create-request';
  static const String profile = '$baseUrl/profile';

  static String cms(String type) => '$baseUrl/cms/$type';

  static String mediaUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    return '$imageBaseUrl${path.replaceFirst(RegExp(r'^/'), '')}';
  }
}
