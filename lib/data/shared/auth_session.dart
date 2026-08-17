import '../models/user_model.dart';
import '../../utils/db_helper.dart';

class AuthSession {
  AuthSession._();

  static final AuthSession instance = AuthSession._();

  UserModel? user;

  String? get token => user?.token ?? DbHelper().getUserToken();

  Future<void> restore() async {
    if (DbHelper().getIsLoggedIn()) {
      user = DbHelper().getUserModel();
    }
  }

  Future<void> setUser(UserModel value) async {
    user = value;
    await DbHelper().saveLoginSession(value);
  }

  Future<void> clear() async {
    user = null;
    await DbHelper().clearLoginSession();
  }
}
