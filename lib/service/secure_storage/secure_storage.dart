import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static setUserToken(String userToken) async {
    await _storage.write(key: 'userToken', value: userToken);
  }

  static Future<String?> readUserToken() async {
    var readData = await _storage.read(key: 'userToken');
    return readData;
  }

  static deleteUserToken() async {
    await _storage.delete(key: 'userToken');
  }

  static setUserIdentifier(String identifier) async {
    await _storage.write(key: 'userIdentifier', value: identifier);
  }

  static Future<String?> readUserIdentifier() async {
    var readData = await _storage.read(key: 'userIdentifier');
    return readData;
  }

  static deleteUserIdentifier() async {
    await _storage.delete(key: 'userToken');
  }
}
