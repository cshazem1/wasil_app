import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppException extends Equatable {
  final String message;
  const AppException({required this.message});

  @override
  List<Object?> get props => [message];
}

class GenericAppException extends AppException {
  const GenericAppException({required super.message});
}

AppException mapAppException({required Object exception}) {
  if (exception is AppException) {
    return exception;
  } else if (exception is SocketException) {
    return GenericAppException(message: "No internet connection.");
  } else if (exception is DioException) {
    return _dioExceptions(exception);
  } else if (exception is FirebaseAuthException) {
    return _firebaseExceptions(exception);
  }

  return GenericAppException(message: "Something went wrong. Please try again.");
}

AppException _dioExceptions(DioException exception) {
  if (exception.error is AppException) {
    return exception.error! as AppException;
  }

  late final String message;

  switch (exception.type) {
    case DioExceptionType.connectionError:
      message = "Connection error.";
      break;
    case DioExceptionType.receiveTimeout:
      message = "Receive timeout.";
      break;
    case DioExceptionType.sendTimeout:
      message = "Send timeout.";
      break;
    case DioExceptionType.connectionTimeout:
      message = "Connection timeout.";
      break;
    case DioExceptionType.cancel:
      message = "Request was cancelled.";
      break;
    default:
      message = "Unexpected error from server.";
  }

  return GenericAppException(message: message);
}

AppException _firebaseExceptions(FirebaseException exception) {
  late final String message;

  switch (exception.code) {
    case 'account-exists-with-different-credential':
      message = "Account exists with different credentials.";
      break;
    case 'invalid-credential':
      message = "Invalid credentials provided.";
      break;
    case 'operation-not-allowed':
      message = "This operation is not allowed.";
      break;
    case 'user-disabled':
      message = "This user account has been disabled.";
      break;
    case 'user-not-found':
      message = "User not found.";
      break;
    case 'wrong-password':
      message = "Incorrect password.";
      break;
    case 'email-already-in-use':
      message = "This email is already in use.";
      break;
    case 'invalid-email':
      message = "Invalid email address.";
      break;
    case 'credential-already-in-use':
      message = "Credential already in use.";
      break;
    case 'weak-password':
      message = "Password is too weak.";
      break;
    case 'internal-error':
      message = "Internal error occurred.";
      break;
    case 'network-request-failed':
      message = "Network request failed.";
      break;
    default:
      message = "Authentication error occurred.";
  }

  return GenericAppException(message: message);
}
