import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage();

  static const _keyfullName = "fullname";
  static const _keyEmail = "email";
  static const _keyUID = "userUID";
  static const _isPrivateEnabled = "isPFEnabled";


  static Future setFullName(String fullName) async => await _storage.write(key: _keyfullName, value: fullName);

  static Future<String?> getFullName() async => await _storage.read(key: _keyfullName);

  static Future setEmail(String email) async => await _storage.write(key: _keyEmail, value: email);

  static Future<String?> getEmail() async => await _storage.read(key: _keyEmail);

  static Future setUID(String uid) async => await _storage.write(key: _keyUID, value: uid);

  static Future<String?> getUID() async => await _storage.read(key: _keyUID);

  static Future setIsPrivateEnabled(bool isEnabled) async => await _storage.write(key: _isPrivateEnabled, value: isEnabled.toString());

  static Future<String?> getIsPrivateEnabled() async => await _storage.read(key: _isPrivateEnabled);


  
  static Future clearStorageData() async => await _storage.deleteAll();



}