import 'package:chef_app/features/auth/data/models/user_model.dart';
import 'package:chef_app/features/auth/data/repositories/clients/auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthClient implements AuthClient {
  final SupabaseClient client;

  SupabaseAuthClient(this.client);

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
}
