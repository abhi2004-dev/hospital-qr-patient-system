class Validators {
  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    // Basic email pattern
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null; // valid
  }

  /// Validate Password (for login and registration)
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  /// Validate Phone Number (10 digits)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }

    return null;
  }

  /// Validate Name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }

    return null;
  }

  /// Validate Address
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }

    return null;
  }

  /// Validate DOB (Basic check)
  static String? validateDOB(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Date of birth is required";
    }

    return null;
  }
}
