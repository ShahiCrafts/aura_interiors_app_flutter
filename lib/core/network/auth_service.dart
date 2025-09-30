import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Service class to wrap all token-related operations.
class AuthService {
  // Immutable storage to ensure singleton behavior.
  final _storage = const FlutterSecureStorage();
  // All instances of this service class shares the same key.
  static const _accessTokenKey = 'access_token';

  // Storage operations are asynchronous as it involves platform channels and disk encryption.
  Future<void> signIn(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> signOut() async {
    await _storage.delete(key: _accessTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }
}
