enum BookingStatus {
  pending,
  assigned,
  inProgress,
  completed,
  cancelled,
  unknown,
}

class BookingModel {
  const BookingModel({
    this.id,
    this.customerName,
    this.phoneNumber,
    this.countryCode,
    this.productName,
    this.productImage,
    this.pickupAddress,
    this.dropoffAddress,
    this.pickupDate,
    this.pickupTime,
    this.instructions,
    this.status = BookingStatus.unknown,
    this.driver,
    this.createdAt,
  });

  final int? id;
  final String? customerName;
  final String? phoneNumber;
  final String? countryCode;
  final String? productName;
  final String? productImage;
  final String? pickupAddress;
  final String? dropoffAddress;
  final DateTime? pickupDate;
  final String? pickupTime;
  final String? instructions;
  final BookingStatus status;
  final DriverModel? driver;
  final DateTime? createdAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: _int(json['id'] ?? json['bookingID'] ?? json['requestID']),
    customerName: _string(json, 'customerName', 'customer_name'),
    phoneNumber: _string(json, 'phoneNumber', 'phone_number'),
    countryCode: _string(json, 'countryCode', 'country_code'),
    productName: _string(json, 'productName', 'product_name'),
    productImage: _string(json, 'productImage', 'product_image'),
    pickupAddress: _string(json, 'pickupAddress', 'pickup_address'),
    dropoffAddress: _string(json, 'dropoffAddress', 'dropoff_address'),
    pickupDate: _date(json['pickupDate'] ?? json['pickup_date']),
    pickupTime: _string(json, 'pickupTime', 'pickup_time'),
    instructions: json['instructions']?.toString(),
    status: _status(json['status']),
    driver: json['driver'] is Map
        ? DriverModel.fromJson(Map<String, dynamic>.from(json['driver'] as Map))
        : null,
    createdAt: _date(json['createdAt'] ?? json['created_at']),
  );

  static List<BookingModel> fromJsonList(dynamic value) => value is List
      ? value
            .whereType<Map>()
            .map(
              (item) => BookingModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList()
      : <BookingModel>[];

  Map<String, dynamic> toJson() => {
    'id': id,
    'customerName': customerName,
    'phoneNumber': phoneNumber,
    'countryCode': countryCode,
    'productName': productName,
    'productImage': productImage,
    'pickupAddress': pickupAddress,
    'dropoffAddress': dropoffAddress,
    'pickupDate': pickupDate?.toIso8601String(),
    'pickupTime': pickupTime,
    'instructions': instructions,
    'status': status.name,
    'driver': driver?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
  };
}

class DriverModel {
  const DriverModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.image,
    this.rating,
  });
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? image;
  final double? rating;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    id: _int(json['id'] ?? json['driverID']),
    name: json['name']?.toString(),
    phoneNumber: _string(json, 'phoneNumber', 'phone_number'),
    image: json['image']?.toString(),
    rating: json['rating'] is num
        ? (json['rating'] as num).toDouble()
        : double.tryParse('${json['rating']}'),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'image': image,
    'rating': rating,
  };
}

int? _int(dynamic value) => value is int ? value : int.tryParse('$value');
DateTime? _date(dynamic value) =>
    value == null ? null : DateTime.tryParse('$value');
String? _string(Map<String, dynamic> json, String camel, String snake) =>
    json[camel]?.toString() ?? json[snake]?.toString();
BookingStatus _status(dynamic value) {
  final normalized = '$value'
      .replaceAll('_', '')
      .replaceAll(' ', '')
      .toLowerCase();
  return BookingStatus.values.firstWhere(
    (status) => status.name.toLowerCase() == normalized,
    orElse: () => BookingStatus.unknown,
  );
}
