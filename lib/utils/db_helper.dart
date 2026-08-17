import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../data/models/user_model.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper _instance = DbHelper._();
  factory DbHelper() => _instance;

  static const String _container = 'fndStore';
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _userId = 'userId';
  static const String _userToken = 'userToken';
  static const String _userModel = 'userModel';

  static GetStorage? _storage;

  static Future<void> init() async {
    await GetStorage.init(_container);
    _storage = GetStorage(_container);
  }

  Future<void> saveIsLoggedIn(bool value) => _write(_isLoggedIn, value);

  bool getIsLoggedIn() => _storage?.read<bool>(_isLoggedIn) ?? false;

  Future<void> saveUserId(String? value) => _write(_userId, value);

  String? getUserId() => _storage?.read<String>(_userId);

  Future<void> saveUserToken(String? value) => _write(_userToken, value);

  String? getUserToken() => _storage?.read<String>(_userToken);

  Future<void> saveUserModel(UserModel? user) async {
    await _write(_userModel, user == null ? null : jsonEncode(user.toJson()));
  }

  UserModel? getUserModel() {
    final value = _storage?.read<String>(_userModel);
    if (value == null || value.isEmpty) return null;
    try {
      return UserModel.fromJson(
        Map<String, dynamic>.from(jsonDecode(value) as Map),
      );
    } on FormatException {
      return null;
    }
  }

  Future<void> saveLoginSession(UserModel user) async {
    await Future.wait<void>([
      saveUserModel(user),
      saveUserId(user.id),
      saveUserToken(user.token),
      saveIsLoggedIn(true),
    ]);
  }

  Future<void> clearLoginSession() async {
    final storage = _storage;
    if (storage == null) return;
    await Future.wait<void>([
      storage.remove(_userModel),
      storage.remove(_userId),
      storage.remove(_userToken),
      storage.remove(_isLoggedIn),
    ]);
  }

  Future<void> _write(String key, dynamic value) async {
    await _storage?.write(key, value);
  }
}
