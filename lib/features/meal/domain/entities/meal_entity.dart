class MealEntity {
  final String? id;
  final String chefId;
  final String name;
  final String? description;
  final double price;
  final String category;
  final List<String> mealImages;
  final String? howToSell;
  final DateTime createdAt;
  final DateTime updatedAt;

  MealEntity({
    required this.id,
    required this.chefId,
    required this.name,
    this.description,
    required this.price,
    required this.category,
    this.mealImages = const [],
    this.howToSell,
    required this.createdAt,
    required this.updatedAt,
  });

  MealEntity copyWith({
    String? id,
    String? chefId,
    String? name,
    String? description,
    double? price,
    String? category,
    List<String>? mealImages,
    String? howToSell,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealEntity(
      id: id ?? this.id,
      chefId: chefId ?? this.chefId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      mealImages: mealImages ?? this.mealImages,
      howToSell: howToSell ?? this.howToSell,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
