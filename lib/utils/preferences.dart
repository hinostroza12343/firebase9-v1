import 'package:shared_preferences/shared_preferences.dart';

class CartPreference {
  static final CartPreference _instance = new CartPreference._internal();
  CartPreference._internal();

  factory CartPreference() {
    return _instance;
  }

  late SharedPreferences _preferences;

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  set quantity(int value) {
    _preferences.setInt("quantity", value);
  }

  int get quantity {
    return _preferences.getInt("quantity") ?? 0;
  }
}
