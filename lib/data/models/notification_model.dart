class NotificationModel {
  const NotificationModel({
    this.id,
    this.title,
    this.message,
    this.bookingId,
    this.isRead = false,
    this.createdAt,
  });
  final int? id;
  final String? title;
  final String? message;
  final int? bookingId;
  final bool isRead;
  final DateTime? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: _toInt(json['id']),
        title: json['title']?.toString(),
        message: json['message']?.toString(),
        bookingId: _toInt(json['bookingID'] ?? json['booking_id']),
        isRead:
            json['isRead'] == true ||
            json['is_read'] == 1 ||
            json['status'] == 1,
        createdAt: DateTime.tryParse(
          '${json['createdAt'] ?? json['created_at'] ?? ''}',
        ),
      );
  static List<NotificationModel> fromJsonList(dynamic value) => value is List
      ? value
            .whereType<Map>()
            .map(
              (item) =>
                  NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList()
      : <NotificationModel>[];
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'bookingID': bookingId,
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
  };
}

int? _toInt(dynamic value) => value is int ? value : int.tryParse('$value');
