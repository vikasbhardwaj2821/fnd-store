class ApiResponse<T> {
  const ApiResponse({
    required this.success,
    this.code,
    this.message,
    this.body,
  });
  final bool success;
  final int? code;
  final String? message;
  final T? body;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    final payload = json.containsKey('body')
        ? json['body']
        : json.containsKey('data')
        ? json['data']
        : json['url'];
    return ApiResponse<T>(
      success:
          json['success'] == true ||
          json['status'] == true ||
          json['status'] == 200,
      code: json['code'] is int
          ? json['code'] as int
          : json['status'] is int
          ? json['status'] as int
          : null,
      message: json['message']?.toString(),
      body: payload == null ? null : fromJson(payload),
    );
  }
}
