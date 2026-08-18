class UserModel {
  const UserModel({
    this.id,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.countryCode,
    this.otp,
    this.profileStep,
    this.profilePicture,
    this.token,
    this.language,
    this.wallet,
    this.isOnline,
    this.isNotificationOn,
    this.status,
    this.approvalStatus,
    this.deviceToken,
    this.permissions,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.driverDocuments = const [],
    this.vehicles = const [],
    this.stores = const [],
    this.store,
  });

  final String? id;
  final int? role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;
  final String? otp;
  final int? profileStep;
  final String? profilePicture;
  final String? token;
  final int? language;
  final num? wallet;
  final int? isOnline;
  final int? isNotificationOn;
  final int? status;
  final int? approvalStatus;
  final String? deviceToken;
  final dynamic permissions;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final List<Map<String, dynamic>> driverDocuments;
  final List<Map<String, dynamic>> vehicles;
  final List<StoreModel> stores;
  final StoreModel? store;

  String get fullName => [
    firstName,
    lastName,
  ].where((value) => value != null && value.trim().isNotEmpty).join(' ');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : json['profile'] is Map
        ? Map<String, dynamic>.from(json['profile'] as Map)
        : json;

    return UserModel(
      id: userJson['id']?.toString() ?? userJson['userID']?.toString(),
      role: _asInt(userJson['role']),
      firstName:
          userJson['firstName']?.toString() ??
          userJson['first_name']?.toString(),
      lastName:
          userJson['lastName']?.toString() ?? userJson['last_name']?.toString(),
      email: userJson['email']?.toString(),
      phoneNumber:
          userJson['phoneNumber']?.toString() ??
          userJson['mobile_number']?.toString(),
      countryCode:
          userJson['countryCode']?.toString() ??
          userJson['country_code']?.toString(),
      otp: userJson['otp']?.toString(),
      profileStep: _asInt(userJson['profileStep'] ?? userJson['profile_step']),
      profilePicture:
          userJson['profilePicture']?.toString() ??
          userJson['profile_picture']?.toString(),
      token: json['token']?.toString() ?? userJson['token']?.toString(),
      language: _asInt(userJson['language']),
      wallet: _asNum(userJson['wallet']),
      isOnline: _asInt(userJson['isOnline']),
      isNotificationOn: _asInt(userJson['isNotificationOn']),
      status: _asInt(userJson['status']),
      approvalStatus: _asInt(userJson['approvalStatus']),
      deviceToken: userJson['deviceToken']?.toString(),
      permissions: userJson['permissions'],
      createdAt: _asDate(userJson['createdAt']),
      updatedAt: _asDate(userJson['updatedAt']),
      deletedAt: _asDate(userJson['deletedAt']),
      driverDocuments: _asMapList(userJson['driverDocuments']),
      vehicles: _asMapList(userJson['vehicles']),
      stores: _asStoreList(userJson['stores']),
      store: userJson['store'] is Map
          ? StoreModel.fromJson(
              Map<String, dynamic>.from(userJson['store'] as Map),
            )
          : _firstStore(userJson['stores']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'countryCode': countryCode,
    'otp': otp,
    'profileStep': profileStep,
    'profilePicture': profilePicture,
    'token': token,
    'language': language,
    'wallet': wallet,
    'isOnline': isOnline,
    'isNotificationOn': isNotificationOn,
    'status': status,
    'approvalStatus': approvalStatus,
    'deviceToken': deviceToken,
    'permissions': permissions,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
    'driverDocuments': driverDocuments,
    'vehicles': vehicles,
    'stores': stores.map((item) => item.toJson()).toList(),
    'store': store?.toJson(),
  };

  UserModel copyWith({
    String? id,
    int? role,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? countryCode,
    String? otp,
    int? profileStep,
    String? profilePicture,
    String? token,
    int? language,
    num? wallet,
    int? isOnline,
    int? isNotificationOn,
    int? status,
    int? approvalStatus,
    String? deviceToken,
    dynamic permissions,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Map<String, dynamic>>? driverDocuments,
    List<Map<String, dynamic>>? vehicles,
    List<StoreModel>? stores,
    StoreModel? store,
  }) {
    return UserModel(
      id: id ?? this.id,
      role: role ?? this.role,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      otp: otp ?? this.otp,
      profileStep: profileStep ?? this.profileStep,
      profilePicture: profilePicture ?? this.profilePicture,
      token: token ?? this.token,
      language: language ?? this.language,
      wallet: wallet ?? this.wallet,
      isOnline: isOnline ?? this.isOnline,
      isNotificationOn: isNotificationOn ?? this.isNotificationOn,
      status: status ?? this.status,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      deviceToken: deviceToken ?? this.deviceToken,
      permissions: permissions ?? this.permissions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      driverDocuments: driverDocuments ?? this.driverDocuments,
      vehicles: vehicles ?? this.vehicles,
      stores: stores ?? this.stores,
      store: store ?? this.store,
    );
  }
}

class StoreModel {
  const StoreModel({
    this.id,
    this.name,
    this.location,
    this.image,
    this.latitude,
    this.longitude,
  });

  final String? id;
  final String? name;
  final String? location;
  final String? image;
  final double? latitude;
  final double? longitude;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json['id']?.toString() ?? json['storeID']?.toString(),
    name:
        json['name']?.toString() ??
        json['storeName']?.toString() ??
        json['store_name']?.toString(),
    location: json['location']?.toString() ?? json['storeLocation']?.toString(),
    image:
        json['image']?.toString() ??
        json['storeImage']?.toString() ??
        json['store_image']?.toString(),
    latitude: _asDouble(json['latitude']),
    longitude: _asDouble(json['longitude']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'image': image,
    'latitude': latitude,
    'longitude': longitude,
  };
}

int? _asInt(dynamic value) => value is int ? value : int.tryParse('$value');
num? _asNum(dynamic value) => value is num ? value : num.tryParse('$value');
double? _asDouble(dynamic value) =>
    value is num ? value.toDouble() : double.tryParse('$value');
DateTime? _asDate(dynamic value) =>
    value == null ? null : DateTime.tryParse('$value');
List<Map<String, dynamic>> _asMapList(dynamic value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList()
    : <Map<String, dynamic>>[];
List<StoreModel> _asStoreList(dynamic value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => StoreModel.fromJson(Map<String, dynamic>.from(item)))
          .toList()
    : <StoreModel>[];

StoreModel? _firstStore(dynamic value) => value is List && value.isNotEmpty
    ? StoreModel.fromJson(Map<String, dynamic>.from(value.first as Map))
    : null;
