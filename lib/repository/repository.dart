import 'package:aim_digital_technologies_test_flutter/data/network/base_firebase_api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Repository {
  Future<UserCredential> loginUser(
      {required String email, required String password});

  Future<UserCredential> registerUser(
      {required String email, required String password});

  Future<bool> isTableExist({required String table});

  Future<void> logout();
}

class RepositoryImpl implements Repository {
  final BaseFirebaseApiService _firebaseApiService =
      BaseFirebaseApiServiceImpl();

  @override
  Future<bool> isTableExist({required String table}) async {
    return true;
  }

  @override
  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _firebaseApiService.loginUser(email: email, password: password);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          _firebaseApiService.registerUser(email: email, password: password);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseApiService.logout();
    } catch (e) {
      rethrow;
    }
  }
}
