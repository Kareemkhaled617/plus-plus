import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static final SecureStorageHelper _instance = SecureStorageHelper._internal();

  factory SecureStorageHelper() => _instance;

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SecureStorageHelper._internal();

  /// Save data securely
  Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Retrieve data securely
  Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a specific key
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all secure storage data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
