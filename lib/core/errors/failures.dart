import 'package:supabase_flutter/supabase_flutter.dart';

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
        return SupabaseFailure(errMessage: 'Too many attempts. Please try again later.');
      default:
        return SupabaseFailure.fromUnknown(e);
    }
  }

  factory SupabaseFailure.fromUnknown(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('socketexception') ||
        msg.contains('failed host lookup') ||
        msg.contains('network') ||
        msg.contains('connection')) {
      return SupabaseFailure(errMessage: 'No internet connection. Please check your network.');
    }
    return SupabaseFailure(errMessage: 'Something went wrong. Please try again.');
  }
}