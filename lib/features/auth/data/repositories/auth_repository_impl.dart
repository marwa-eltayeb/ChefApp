import 'package:chef_app/core/errors/failures.dart';
import 'package:chef_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:chef_app/features/auth/domain/entities/user_entity.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource client;

  AuthRepositoryImpl(this.client);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userModel = await client.login(email, password);
      return userModel.toEntity();
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await client.forgotPassword(email);
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<void> resetPassword(String newPassword, {String? token}) async {
    try {
      await client.resetPassword(newPassword, token: token);
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<String?> getCurrentUserId() async {
    try {
      return await client.getCurrentUserId();
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await client.changePassword(oldPassword: oldPassword, newPassword: newPassword);
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.logout();
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? brandName,
    String? description,
  }) async {
    try {
      final userModel = await client.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        brandName: brandName,
        description: description,
      );
      return userModel.toEntity();
    } on AuthException catch (e) {
      throw SupabaseFailure.fromAuthException(e);
    }
  }
}