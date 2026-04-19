import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HouseholdStorage {
  HouseholdStorage._();
  static final instance = HouseholdStorage._();

  static const _key = 'last_household_id';
  final _storage = const FlutterSecureStorage();

  Future<String?> read() => _storage.read(key: _key);
  Future<void> write(String id) => _storage.write(key: _key, value: id);
  Future<void> clear() => _storage.delete(key: _key);
}
