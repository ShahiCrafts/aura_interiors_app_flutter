import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Service class to wrap all token-related operations.
class AuthService {
  // Immutable storage to ensure singleton behavior.
  final _storage = const FlutterSecureStorage();
  // All instances of this service class shares the same key.
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // Storage operations are asynchronous as it involves platform channels and disk encryption.
  Future<void> saveTokens(TokenEntity tokens) async {
    await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> signOut() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}
