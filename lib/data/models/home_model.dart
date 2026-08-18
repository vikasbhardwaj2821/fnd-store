class HomeModel {
  const HomeModel({
    this.user,
    this.totalDelivered,
    this.todayBookings = const [],
    this.raw = const {},
  });

  final HomeUser? user;
  final int? totalDelivered;
  final List<HomeBooking> todayBookings;
  final Map<String, dynamic> raw;

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    return HomeModel(
      user: data['user'] is Map
          ? HomeUser.fromJson(Map<String, dynamic>.from(data['user'] as Map))
          : null,
      totalDelivered: _asInt(data['totalDelivered']),
      todayBookings: data['todayBookings'] is List
          ? (data['todayBookings'] as List)
              .whereType<Map>()
              .map((item) => HomeBooking.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : const [],
      raw: data,
    );
  }
}

class HomeUser {
  const HomeUser({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;

  factory HomeUser.fromJson(Map<String, dynamic> json) => HomeUser(
        id: json['id']?.toString(),
        firstName: json['firstName']?.toString(),
        lastName: json['lastName']?.toString(),
        profilePicture: json['profilePicture']?.toString(),
      );
}

class HomeBooking {
  const HomeBooking({
    this.id,
    this.orderNumber,
    this.storeId,
    this.driverId,
    this.recipientName,
    this.recipientPhone,
    this.packageImage,
    this.packageInstructions,
    this.pickupLocation,
    this.dropoffLocation,
    this.scheduledDate,
    this.scheduledTimeFrom,
    this.scheduledTimeTo,
    this.status,
    this.distance,
    this.price,
    this.cancelReason,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.driver,
  });

  final String? id;
  final String? orderNumber;
  final String? storeId;
  final String? driverId;
  final String? recipientName;
  final String? recipientPhone;
  final String? packageImage;
  final String? packageInstructions;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String? scheduledDate;
  final String? scheduledTimeFrom;
  final String? scheduledTimeTo;
  final int? status;
  final num? distance;
  final num? price;
  final String? cancelReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final Map<String, dynamic>? driver;

  factory HomeBooking.fromJson(Map<String, dynamic> json) => HomeBooking(
        id: json['id']?.toString(),
        orderNumber: json['orderNumber']?.toString(),
        storeId: json['storeId']?.toString(),
        driverId: json['driverId']?.toString(),
        recipientName: json['recipientName']?.toString(),
        recipientPhone: json['recipientPhone']?.toString(),
        packageImage: json['packageImage']?.toString(),
        packageInstructions: json['packageInstructions']?.toString(),
        pickupLocation: json['pickupLocation']?.toString(),
        dropoffLocation: json['dropoffLocation']?.toString(),
        scheduledDate: json['scheduledDate']?.toString(),
        scheduledTimeFrom: json['scheduledTimeFrom']?.toString(),
        scheduledTimeTo: json['scheduledTimeTo']?.toString(),
        status: _asInt(json['status']),
        distance: _asNum(json['distance']),
        price: _asNum(json['price']),
        cancelReason: json['cancelReason']?.toString(),
        createdAt: _asDate(json['createdAt']),
        updatedAt: _asDate(json['updatedAt']),
        deletedAt: _asDate(json['deletedAt']),
        driver: json['driver'] is Map
            ? Map<String, dynamic>.from(json['driver'] as Map)
            : null,
      );
}

int? _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '');

num? _asNum(dynamic value) =>
    value is num ? value : num.tryParse(value?.toString() ?? '');

DateTime? _asDate(dynamic value) =>
    value == null ? null : DateTime.tryParse(value.toString());
