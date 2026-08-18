class RequestTrackModel {
  const RequestTrackModel({
    this.request,
    this.driverRating,
    this.driverDeliveryCount,
    this.statusTimeline = const [],
  });

  final TrackedRequest? request;
  final num? driverRating;
  final int? driverDeliveryCount;
  final List<RequestStatusStep> statusTimeline;

  factory RequestTrackModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;
    return RequestTrackModel(
      request: data['request'] is Map
          ? TrackedRequest.fromJson(
              Map<String, dynamic>.from(data['request'] as Map),
            )
          : null,
      driverRating: _asNum(data['driverRating']),
      driverDeliveryCount: _asInt(data['driverDeliveryCount']),
      statusTimeline: data['statusTimeline'] is List
          ? (data['statusTimeline'] as List)
              .whereType<Map>()
              .map(
                (item) =>
                    RequestStatusStep.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList()
          : const [],
    );
  }
}

class TrackedRequest {
  const TrackedRequest({
    this.id,
    this.orderNumber,
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
    this.price,
    this.storeName,
    this.storeLocation,
    this.driver,
  });

  final String? id;
  final String? orderNumber;
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
  final num? price;
  final String? storeName;
  final String? storeLocation;
  final Map<String, dynamic>? driver;

  factory TrackedRequest.fromJson(Map<String, dynamic> json) => TrackedRequest(
        id: json['id']?.toString(),
        orderNumber: json['orderNumber']?.toString(),
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
        price: _asNum(json['price']),
        storeName: json['store'] is Map
            ? (json['store'] as Map)['storeName']?.toString()
            : null,
        storeLocation: json['store'] is Map
            ? (json['store'] as Map)['location']?.toString()
            : null,
        driver: json['driver'] is Map
            ? Map<String, dynamic>.from(json['driver'] as Map)
            : null,
      );
}

class RequestStatusStep {
  const RequestStatusStep({this.step, this.status});
  final String? step;
  final String? status;

  factory RequestStatusStep.fromJson(Map<String, dynamic> json) =>
      RequestStatusStep(
        step: json['step']?.toString(),
        status: json['status']?.toString(),
      );
}

int? _asInt(dynamic value) =>
    value is int ? value : int.tryParse(value?.toString() ?? '');

num? _asNum(dynamic value) =>
    value is num ? value : num.tryParse(value?.toString() ?? '');
