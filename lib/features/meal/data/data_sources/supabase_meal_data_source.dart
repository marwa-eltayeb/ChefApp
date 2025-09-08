import 'dart:io';
import 'package:chef_app/features/meal/data/data_sources/meal_data_source.dart';
import 'package:chef_app/features/meal/data/models/meal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMealDataSource implements MealDataSource {
  final SupabaseClient client;

  SupabaseMealDataSource(this.client);

  @override
  Future<MealModel> addMeal(MealModel meal) async {
    final response = await client
        .from('meals')
        .insert(meal.toJson())
        .select()
        .single();
    return MealModel.fromJson(response);
  }

  @override
  Future<void> deleteMeal(String mealId) async {
    await client.from('meals').delete().eq('id', mealId);
  }

  @override
  Future<MealModel> editMeal(MealModel meal) async {
    if (meal.id == null) {
      throw ArgumentError("Meal ID is required to edit");
    }

    final response = await client
        .from('meals')
        .update(meal.toJson())
        .eq('id', meal.id!)
        .select()
        .single();

    return MealModel.fromJson(response);
  }

  @override
  Future<List<MealModel>> loadMeals({String? chefId}) async {
    final query = client.from('meals').select();
    if (chefId != null) {
      query.eq('chef_id', chefId);
    }
    final response = await query;
    return (response as List<dynamic>).map((e) => MealModel.fromJson(e)).toList();
  }

  @override
  Future<String?> uploadMealImage(File imageFile, String userId) async {
    final fileExt = imageFile.path.split('.').last.toLowerCase();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await client.storage.from('meal-images').upload(filePath, imageFile);
    return client.storage.from('meal-images').getPublicUrl(filePath);
  }
}
