import 'package:chef_app/features/auth/data/models/user_model.dart';
import 'package:chef_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDataSource implements AuthDataSource {
  final SupabaseClient client;

  SupabaseAuthDataSource(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final res = await client.auth.signInWithPassword(email: email, password: password);
    return UserModel(
      id: res.user!.id,
      email: res.user!.email!,
      token: res.session?.accessToken,
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> resetPassword(String newPassword, {String? token}) async {
    await client.auth.updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future<String?> getCurrentUserId() async {
    final user = client.auth.currentUser;
    return user?.id;
  }
}
