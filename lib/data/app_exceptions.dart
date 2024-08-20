import 'package:aim_digital_technologies_test_flutter/utils/constants.dart';

class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix${_message ?? ''}';
  }
}

class UserNotFoundException extends AppExceptions {
  UserNotFoundException([String? message])
      : super(
          message,
          Constants.userNotFoundException,
        );
}

class WrongPasswordException extends AppExceptions {
  WrongPasswordException([String? message])
      : super(
          message,
          Constants.wrongPasswordProvidedForThisUserException,
        );
}

class WeakPasswordException extends AppExceptions {
  WeakPasswordException([String? message])
      : super(
          message,
          Constants.passwordIsTooWeakException,
        );
}

class EmailAlreadyInUseException extends AppExceptions {
  EmailAlreadyInUseException([String? message])
      : super(
          message,
          Constants.emailAlreadyExistException,
        );
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(
          message,
          Constants.errorDuringCommunicationException,
        );
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message, Constants.inValidRequestException);
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException([String? message])
      : super(message, Constants.unAuthorizeRequestException);
}

class InValidInputException extends AppExceptions {
  InValidInputException([String? message])
      : super(message, Constants.inValidInputRequestException);
}

class TimeOutException extends AppExceptions {
  TimeOutException([String? message])
      : super(message, Constants.timeOutRequestException);
}
