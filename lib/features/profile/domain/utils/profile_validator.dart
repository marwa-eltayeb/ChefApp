class ProfileValidator {

  static const int _minPasswordLength = 8;

  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Name cannot be empty";
    }
    if (name.length < 2) {
      return "Name must be at least 2 characters long";
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return "Phone cannot be empty";
    }

    // Egyptian phone number regex for the main 4 companies
    final regex = RegExp(r'^(?:\+20|0)?(10|11|12|15|18)[0-9]{8}$');

    if (!regex.hasMatch(phone)) {
      return "Invalid Egyptian phone number";
    }

    return null;
  }


  static String? validateBrandName(String? brandName) {
    if (brandName != null && brandName.length < 2) {
      return "Brand name must be at least 2 characters long";
    }
    return null;
  }

  static String? validateMinCharge(int? minCharge) {
    if (minCharge == null) {
      return "Minimum charge is required";
    }
    if (minCharge < 0) {
      return "Minimum charge must be a positive number";
    }
    return null;
  }

  static String? validateDescription(String? description) {
    if (description != null && description.length > 500) {
      return "Description cannot exceed 500 characters";
    }
    return null;
  }

  static String? validateProfilePic(String? url) {
    if (url != null && !Uri.tryParse(url)!.isAbsolute) {
      return "Invalid profile picture URL";
    }
    return null;
  }
}

