import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product_management/utilities/appconfigs.dart';

class SecureStorageHelper {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> storeCredentials(String email) async {
    await secureStorage.write(key: AppConfig.userIDPrefKey, value: email);
  }

  Future<String?> getCredentials() async {
    final email = await secureStorage.read(key: AppConfig.userIDPrefKey);
    return email;
  }

  Future<void> storePin(String pin) async {
    await secureStorage.write(key: AppConfig.pinValueKey, value: pin);
  }

  Future<String?> getPin() async {
    return await secureStorage.read(key: AppConfig.pinValueKey);
  }
}
