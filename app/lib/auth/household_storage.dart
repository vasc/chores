import 'package:shared_preferences/shared_preferences.dart';

class HouseholdStorage {
  HouseholdStorage._();
  static final instance = HouseholdStorage._();

  static const _key = 'last_household_id';

  Future<String?> read() async =>
      (await SharedPreferences.getInstance()).getString(_key);
  Future<void> write(String id) async =>
      (await SharedPreferences.getInstance()).setString(_key, id);
  Future<void> clear() async =>
      (await SharedPreferences.getInstance()).remove(_key);
}
