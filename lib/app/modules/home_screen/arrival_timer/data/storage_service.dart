import '../../../../core/storage/secure_storage_helper.dart';

class StorageService {
  static const _keyStartTime = 'arrival_start_time';

  Future<void> saveStartTime(DateTime time) async {
    final milliseconds = time.millisecondsSinceEpoch.toString();
    await SecureStorageHelper().saveData(_keyStartTime, milliseconds);
  }

  Future<DateTime?> getStartTime() async {
    final millisStr = await SecureStorageHelper().getData(_keyStartTime);
    if (millisStr == null) return null;

    final millis = int.tryParse(millisStr);
    if (millis == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> clearStartTime() async {
    await SecureStorageHelper().deleteData(_keyStartTime);
  }
}
