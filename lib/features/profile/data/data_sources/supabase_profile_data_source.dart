import 'dart:io';
import 'package:chef_app/features/profile/data/models/profile_model.dart';
import 'package:chef_app/features/profile/data/data_sources/profile_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDataSource implements ProfileDataSource {
  final SupabaseClient supabase;

  SupabaseProfileDataSource(this.supabase);

  @override
  Future<ProfileModel> getProfile(String id) async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', id)
        .single();

    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final response = await supabase
        .from('profiles')
        .update(profile.toJson(forUpdate: true))
        .eq('id', profile.id)
        .select()
        .single();

    return ProfileModel.fromJson(response);
  }

  @override
  Future<String?> uploadMealImage(File imageFile, String userId) async {
    final fileExt = imageFile.path.split('.').last.toLowerCase();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await supabase.storage.from('chef-images').upload(filePath, imageFile);
    return supabase.storage.from('chef-images').getPublicUrl(filePath);
  }
}
