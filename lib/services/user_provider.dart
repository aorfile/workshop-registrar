import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../controller/user_repo.dart';

enum AuthStatus { initial, authenticated, unauthenticated, authenticating }

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  late SharedPreferences _prefs;

  User? _currentUser;
  bool _loading = false;
  String? _error;
  AuthStatus _authStatus = AuthStatus.initial;

  // SharedPreferences keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _lastFetchKey = 'last_fetch_time';

  // Cache timeout duration
  static const cacheDuration = Duration(hours: 24);

  UserProvider(this._userRepository);

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _loading;
  String? get error => _error;
  AuthStatus get authStatus => _authStatus;
  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;

  // Initialize SharedPreferences
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();

      // Try to load cached user data
      final userData = _prefs.getString(_userKey);
      final token = _prefs.getString(_tokenKey);

      if (userData != null && token != null) {
        try {
          _currentUser = User.fromJson(json.decode(userData));
          _authStatus = AuthStatus.authenticated;
        } catch (e) {
          // Fix: Handle invalid cached data
          await _clearCache();
          _authStatus = AuthStatus.unauthenticated;
          return;
        }

        // Check if we need to refresh user data
        final lastFetchStr = _prefs.getInt(_lastFetchKey);
        if (lastFetchStr != null) {
          final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchStr);
          if (DateTime.now().difference(lastFetch) > cacheDuration) {
            await _refreshUserData();
          }
        } else {
          await _refreshUserData();
        }
      } else {
        _authStatus = AuthStatus.unauthenticated;
      }
    } catch (e) {
      _handleError('Initialization failed', e);
      _authStatus = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadCurrentUser({bool forceRefresh = false}) async {
    if (!forceRefresh && _currentUser != null) {
      final lastFetchStr = _prefs.getInt(_lastFetchKey);
      if (lastFetchStr != null) {
        final lastFetch = DateTime.fromMillisecondsSinceEpoch(lastFetchStr);
        if (DateTime.now().difference(lastFetch) < cacheDuration) {
          return; // Use cached data
        }
      }
    }

    try {
      _setLoading(true);

      final user = await _userRepository.getCurrentUser();
      await _saveUserData(user);
    } catch (e) {
      _handleError('Failed to load user profile', e);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(User userData) async {
    try {
      _setLoading(true);

      final updatedUser = await _userRepository.updateUserProfile(userData);
      await _saveUserData(updatedUser);
    } catch (e) {
      _handleError('Failed to update user profile', e);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(User user) async {
    try {
      _authStatus = AuthStatus.authenticating;
      _setLoading(true);

      final response = await _userRepository.loginUser(user);

      // Fix: Check for null response
      if (response == null) {
        throw Exception('Invalid login response');
      }

      // Fix: Check for null token
      if (response.token == null) {
        throw Exception('No token received');
      }

      // Save token
      await _prefs.setString(_tokenKey, response.token!);

      // Update user data
      final userData = response.toJson();
      if (userData != null) {
        await _saveUserData(User.fromJson(userData));
      } else {
        await loadCurrentUser(forceRefresh: true);
      }

      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _handleError('Login failed', e);
      _authStatus = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);

      // Clear SharedPreferences
      await _clearCache();

      // Clear memory
      _currentUser = null;
      _authStatus = AuthStatus.unauthenticated;

      // Optional: Call logout endpoint
      try {
        await _userRepository.logout();
      } catch (e) {
        // Fix: Don't fail logout if server call fails
        _handleError('Server logout failed', e);
      }
    } catch (e) {
      _handleError('Logout failed', e);
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Private helper methods
  Future<void> _saveUserData(User user) async {
    _currentUser = user;
    _error = null;
    _authStatus = AuthStatus.authenticated;

    // Fix: Use try-catch for JSON encoding
    try {
      final userJson = json.encode(user.toJson());
      // Save to SharedPreferences
      await Future.wait([
        _prefs.setString(_userKey, userJson),
        _prefs.setInt(_lastFetchKey, DateTime.now().millisecondsSinceEpoch),
      ]);
    } catch (e) {
      _handleError('Failed to save user data', e);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> _refreshUserData() async {
    try {
      final user = await _userRepository.getCurrentUser();
      await _saveUserData(user);
    } catch (e) {
      _authStatus = AuthStatus.unauthenticated;
      await _clearCache();
      _handleError('Failed to refresh user data', e);
    }
  }

  Future<void> _clearCache() async {
    await Future.wait([
      _prefs.remove(_tokenKey),
      _prefs.remove(_userKey),
      _prefs.remove(_lastFetchKey),
    ]);
  }

  void _handleError(String message, dynamic error) {
    _error = '$message: ${error.toString()}';
    print('UserProvider Error: $_error'); // For debugging
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Utility methods
  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<void> updateUserField(String field, dynamic value) async {
    if (_currentUser == null) return;

    try {
      final updateData = Map<String, dynamic>.from(_currentUser!.toJson());
      updateData[field] = value;
      await updateUser(User.fromJson(updateData));
    } catch (e) {
      _handleError('Failed to update $field', e);
      rethrow;
    }
  }
}
