import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart';

abstract class Failures {
  final String errMessage;

  Failures({required this.errMessage});

  @override
  String toString() => errMessage;
}

class SupabaseFailure extends Failures {
  SupabaseFailure({required super.errMessage});

  factory SupabaseFailure.fromAuthException(AuthException e) {
    switch (e.statusCode) {
      case '400':
        return SupabaseFailure(errMessage: 'Invalid email or password.');
      case '422':
        return SupabaseFailure(errMessage: 'Email is already registered.');
      case '429':
        return SupabaseFailure(
          errMessage: 'Too many attempts. Please try again later.',
        );
      default:
        return SupabaseFailure.fromUnknown(e);
    }
  }

  factory SupabaseFailure.fromUnknown(Object e) {
    if (_isNetworkError(e.toString().toLowerCase())) {
      return SupabaseFailure(
        errMessage: 'No internet connection. Please check your network.',
      );
    }
    return SupabaseFailure(
      errMessage: 'Something went wrong. Please try again.',
    );
  }
}

class PostgrestFailure extends Failures {
  PostgrestFailure({required super.errMessage});

  factory PostgrestFailure.fromException(Object e) {
    if (e is SocketException || e is ClientException  || _isNetworkError(e.toString().toLowerCase())) {
      return PostgrestFailure(
        errMessage: 'No internet connection. Please check your network.',
      );
    }
    return PostgrestFailure(
        errMessage: 'Something went wrong. Please try again.');
  }
}

class StorageFailure extends Failures {
  StorageFailure({required super.errMessage});

  factory StorageFailure.fromException(Object e) {
    if (e is SocketException || e is ClientException  || _isNetworkError(e.toString().toLowerCase())) {
      return StorageFailure(
        errMessage: 'No internet connection. Please check your network.',
      );
    }
    return StorageFailure(
        errMessage: 'Failed to upload image. Please try again.');
  }
}

bool _isNetworkError(String msg) =>
    msg.contains('socketexception') ||
    msg.contains('clientexception') ||
    msg.contains('failed host lookup');
