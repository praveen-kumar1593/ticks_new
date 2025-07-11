class CustomValidator {
  static String? emailValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression to validate email format
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null; // Email is valid
  }

  static String? passwordValidator({required String? value}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Regular expression to check password complexity
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!passwordRegExp.hasMatch(value)) {
      return 'Password is not strong enough:\n';
      // '- One uppercase letter\n'
      // // '- One lowercase letter\n'
      // // '- One number\n'
      // // '- One special character\n'
      // '- Minimum 8 characters';
    }

    return null; // Password is valid
  }

  static String? confirmPasswordValidator({
    required String? value,
    required String newPassword,
  }) {
    // RLoggerHelper.warning("value $value newPassword $newPassword");
    if (value != null && value == newPassword) {
      return null;
    }
    return "Password Not Match";
  }
}
