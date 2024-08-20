import 'dart:async';
import 'dart:io';

import 'package:aim_digital_technologies_test_flutter/data/app_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseFirebaseApiService {
  Future<UserCredential> registerUser(
      {required String email, required String password});

  Future<UserCredential> loginUser(
      {required String email, required String password});

  Future<void> logout();
}

class BaseFirebaseApiServiceImpl implements BaseFirebaseApiService {
  @override
  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(const Duration(minutes: 1));

      return credential;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      throw TimeOutException();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw FetchDataException();
      }
    } catch (e) {
      throw BadRequestException();
    }
  }

  @override
  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .timeout(const Duration(minutes: 1));
      return credential;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      throw TimeOutException();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw FetchDataException();
      }
    } catch (e) {
      throw BadRequestException();
    }
  }

  @override
  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut().timeout(const Duration(minutes: 1));
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      throw TimeOutException();
    } catch (e) {
      throw BadRequestException();
    }
  }
}
