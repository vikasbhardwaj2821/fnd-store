abstract final class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://app.fnddelivery.com/api/mobile',
  );
  static const String imageBaseUrl = 'https://app.fnddelivery.com/';

  static const String login = '$baseUrl/login';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String signup = '$baseUrl/signup';
  static const String verifySignupOtp = '$baseUrl/signup/verify-otp';
  static const String completeProfile = '$baseUrl/complete-profile';
  static const String logout = '$baseUrl/logout';
  static const String storeDetails = '$baseUrl/store/details';
  static const String createRequest = '$baseUrl/store/create-request';
  static const String storeBookings = '$baseUrl/store/bookings';
  static const String trackRequest = '$baseUrl/store/track';
  static const String support = '$baseUrl/support';
  static const String upload = '$baseUrl/upload';
  static const String home = '$baseUrl/store/home';
  static const String settings = '$baseUrl/settings';
  static const String profile = '$baseUrl/profile';

  static String cms(String type) => '$baseUrl/cms/$type';

  static String mediaUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    return '$imageBaseUrl${path.replaceFirst(RegExp(r'^/'), '')}';
  }
}
