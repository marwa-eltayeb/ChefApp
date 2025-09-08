class MealValidator {

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Meal name is required';
    }
    return null;
  }

  static String? validatePrice(num? value) {
    if (value == null) {
      return 'Price is required';
    }
    if (value < 0) {
      return 'Price cannot be negative';
    }
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category is required';
    }
    return null;
  }

  static String? validateHowToSell(String? value, List<String> allowed) {
    if (value == null || value.trim().isEmpty) {
      return 'Selling method is required';
    }
    if (!allowed.contains(value)) {
      return 'Invalid selling method';
    }
    return null;
  }
}
