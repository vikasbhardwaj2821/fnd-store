import 'dart:io';

import 'package:dio/dio.dart';

class PlaceSuggestion {
  const PlaceSuggestion({required this.id, required this.description});
  final String id;
  final String description;
}

class PlaceLocation {
  const PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
  final String address;
  final double latitude;
  final double longitude;
}

class GooglePlacesService {
  GooglePlacesService({Dio? dio}) : _dio = dio ?? Dio();
  final Dio _dio;

  static String get _apiKey => Platform.isAndroid
      ? 'AIzaSyCtm7WzO7vAtrZCEb7r_xbdo22S5MlQIYk'
      : 'AIzaSyBBryXG0U3HpE0fzMLoS7GuV_9ZMFYuLhQ';

  Future<List<PlaceSuggestion>> autocomplete(String input) async {
    if (input.trim().length < 3) return const [];
    final response = await _dio.post<Map<String, dynamic>>(
      'https://places.googleapis.com/v1/places:autocomplete',
      data: {'input': input.trim()},
      options: Options(
        headers: {
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask':
              'suggestions.placePrediction.placeId,suggestions.placePrediction.text.text',
        },
      ),
    );
    final items = response.data?['suggestions'];
    if (items is! List) return const [];
    return items
        .whereType<Map>()
        .map((item) {
          final prediction = item['placePrediction'];
          if (prediction is! Map) return null;
          final text = prediction['text'];
          final description = text is Map ? text['text']?.toString() : null;
          final id = prediction['placeId']?.toString();
          return id == null || description == null
              ? null
              : PlaceSuggestion(id: id, description: description);
        })
        .whereType<PlaceSuggestion>()
        .toList();
  }

  Future<PlaceLocation?> getPlace(String placeId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'https://places.googleapis.com/v1/places/$placeId',
      options: Options(
        headers: {
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask': 'formattedAddress,location',
        },
      ),
    );
    final data = response.data;
    final location = data?['location'];
    if (data == null || location is! Map) return null;
    final latitude = location['latitude'];
    final longitude = location['longitude'];
    if (latitude is! num || longitude is! num) return null;
    return PlaceLocation(
      address: data['formattedAddress']?.toString() ?? '',
      latitude: latitude.toDouble(),
      longitude: longitude.toDouble(),
    );
  }
}
