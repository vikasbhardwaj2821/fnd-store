class ListResponse<T> {
  const ListResponse({
    required this.success,
    this.code,
    this.message,
    this.body = const [],
  });
  final bool success;
  final int? code;
  final String? message;
  final List<T> body;

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    final payload = json['body'] ?? json['data'];
    return ListResponse<T>(
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
      body: payload is List ? payload.map(fromJson).toList() : <T>[],
    );
  }
}
