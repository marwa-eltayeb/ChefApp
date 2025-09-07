import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';

class MealModel {
  final String? id;
  final String chefId;
  final String name;
  final String? description;
  final double price;
  final String? category;
  final List<String> mealImages;
  final String? howToSell;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealModel({
    this.id,
    required this.chefId,
    required this.name,
    this.description,
    required this.price,
    this.category,
    this.mealImages = const [],
    this.howToSell,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson({bool forUpdate = false}) {
    final data = {
      "chef_id": chefId,
      "name": name,
      "description": description,
      "price": price,
      "category": category,
      "meal_images": mealImages,
      "how_to_sell": howToSell,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };

    if (forUpdate && id != null) {
      data["id"] = id;
    }

    return data;
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json["id"],
      chefId: json["chef_id"],
      name: json["name"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      category: json["category"],
      mealImages: List<String>.from(json["meal_images"] ?? []),
      howToSell: json["how_to_sell"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  // Convert to domain entity
  MealEntity toEntity() {
    return MealEntity(
      id: id,
      chefId: chefId,
      name: name,
      description: description,
      price: price,
      category: category ?? "",
      mealImages: mealImages,
      howToSell: howToSell,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Create model from entity
  factory MealModel.fromEntity(MealEntity entity) {
    return MealModel(
      id: entity.id,
      chefId: entity.chefId,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      category: entity.category,
      mealImages: entity.mealImages,
      howToSell: entity.howToSell,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
